import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(const ResetPasswordState());

  void emailChanged(String v) {
    emit(state.copyWith(email: v, clearError: true, clearMessage: true));
  }

  bool _validate() {
    final email = state.email.trim();
    String? emailError;

    if (email.isEmpty || !email.contains('@')) {
      emailError = 'Please enter a valid email';
    }

    emit(state.copyWith(emailError: emailError));
    return emailError == null;
  }

  Future<void> sendResetLink() async {
    if (!_validate()) return;

    emit(
      state.copyWith(status: ResetPasswordStatus.loading, clearMessage: true),
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: state.email.trim(),
      );

      emit(
        state.copyWith(
          status: ResetPasswordStatus.success,
          message: 'Reset link has been sent to your email',
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Something went wrong';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format';
      }

      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          message: errorMessage,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          message: 'Failed to send reset link',
        ),
      );
    }
  }

  void reset() => emit(const ResetPasswordState());
}
