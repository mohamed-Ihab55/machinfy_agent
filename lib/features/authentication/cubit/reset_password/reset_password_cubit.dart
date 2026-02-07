import 'package:bloc/bloc.dart';
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
      // placeholder (زي اللوجن)
      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: ResetPasswordStatus.success,
          message: 'Reset link sent to your email',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          message: 'Failed to send reset link, try again',
        ),
      );
    } finally {
      // اختياري: رجّعها idle بعد نجاح/فشل
      if (state.status != ResetPasswordStatus.loading) {
        emit(state.copyWith(status: ResetPasswordStatus.idle));
      }
    }
  }

  void reset() => emit(const ResetPasswordState());
}
