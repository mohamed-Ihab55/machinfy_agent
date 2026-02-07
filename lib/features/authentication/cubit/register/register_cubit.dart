import 'package:bloc/bloc.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

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
    if (email.isEmpty || !email.contains('@'))
      emailError = 'Please enter a valid email';

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

    emit(state.copyWith(status: RegisterStatus.loading, clearMessage: true));

    try {
      // placeholder نفس أسلوب اللوجن
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: RegisterStatus.success));
    } catch (_) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          message: 'Registration failed, please try again',
        ),
      );
    } finally {
      if (state.status == RegisterStatus.failure) {
        emit(state.copyWith(status: RegisterStatus.idle));
      }
    }
  }

  void reset() => emit(const RegisterState());
}
