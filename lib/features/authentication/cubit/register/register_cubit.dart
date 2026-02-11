import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void nameChanged(String v) =>
      emit(state.copyWith(name: v, nameError: null, clearMessage: true));

  void emailChanged(String v) =>
      emit(state.copyWith(email: v, emailError: null, clearMessage: true));

  void passwordChanged(String v) => emit(
    state.copyWith(password: v, passwordError: null, clearMessage: true),
  );

  void confirmPasswordChanged(String v) => emit(
    state.copyWith(confirmPassword: v, confirmError: null, clearMessage: true),
  );

  void togglePassword() =>
      emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));

  void toggleConfirmPassword() =>
      emit(state.copyWith(isConfirmHidden: !state.isConfirmHidden));

  void toggleTerms(bool? v) =>
      emit(state.copyWith(acceptTerms: v ?? false, termsError: null));

  bool _validate() {
    final name = state.name.trim();
    final email = state.email.trim();
    final pass = state.password;
    final confirm = state.confirmPassword;

    String? nameError;
    String? emailError;
    String? passError;
    String? confirmError;
    String? termsError;

    if (name.isEmpty) nameError = 'Please enter your full name';

    if (email.isEmpty || !email.contains('@')) {
      emailError = 'Please enter a valid email';
    }

    if (pass.isEmpty || pass.length < 8) {
      passError = 'Password must be at least 8 characters';
    }

    if (confirm.isEmpty) {
      confirmError = 'Please confirm your password';
    } else if (confirm != pass) {
      confirmError = 'Passwords do not match';
    }

    if (!state.acceptTerms) {
      termsError = 'You must accept the terms to continue';
    }

    emit(
      state.copyWith(
        nameError: nameError,
        emailError: emailError,
        passwordError: passError,
        confirmError: confirmError,
        termsError: termsError,
      ),
    );

    return nameError == null &&
        emailError == null &&
        passError == null &&
        confirmError == null &&
        termsError == null;
  }

  Future<void> createAccount() async {
    if (!_validate()) return;

    // امنعي تكرار الضغط وقت loading
    if (state.status == RegisterStatus.loading) return;

    emit(state.copyWith(status: RegisterStatus.loading, clearMessage: true));

    try {
      final name = state.name.trim();
      final email = state.email.trim();
      final pass = state.password;

      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      // اختياري: set display name
      if (name.isNotEmpty) {
        await cred.user?.updateDisplayName(name);
        await cred.user?.reload();
      }

      emit(state.copyWith(status: RegisterStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          message: _mapFirebaseError(e),
        ),
      );

      // رجّعي idle بعد ما الـ UI يلتقط failure ويعرض SnackBar
      emit(state.copyWith(status: RegisterStatus.idle));
    } catch (_) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          message: 'Registration failed, please try again',
        ),
      );

      emit(state.copyWith(status: RegisterStatus.idle));
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use';
      case 'invalid-email':
        return 'Please enter a valid email';
      case 'weak-password':
        return 'Password is too weak';
      case 'operation-not-allowed':
        return 'Email/password sign-up is not enabled';
      case 'network-request-failed':
        return 'Network error, please check your connection';
      default:
        return e.message ?? 'Registration failed, please try again';
    }
  }

  void reset() => emit(const RegisterState());
}
