import 'package:bloc/bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  // بدل controllers: UI تبعت القيم هنا
  void emailChanged(String value) {
    emit(state.copyWith(email: value, emailError: null, clearMessage: true));
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(password: value, passwordError: null, clearMessage: true),
    );
  }

  void toggleRememberMe(bool? value) {
    emit(state.copyWith(rememberMe: value ?? false));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  bool _validate() {
    final email = state.email.trim();
    final pass = state.password;

    String? emailError;
    String? passwordError;

    // نفس validation بتاع ViewModel
    if (email.isEmpty || !email.contains('@')) {
      emailError = 'Please enter a valid email';
    }
    if (pass.isEmpty || pass.length < 6) {
      passwordError = 'Password must be at least 6 characters';
    }

    emit(state.copyWith(emailError: emailError, passwordError: passwordError));

    return emailError == null && passwordError == null;
  }

  Future<void> signIn() async {
    if (!_validate()) return;

    emit(state.copyWith(status: LoginStatus.loading, clearMessage: true));

    try {
      // نفس Future.delayed اللي عندك (placeholder)
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          message: 'Login failed, please try again',
        ),
      );
    } finally {
      // لو نجح مش محتاج نرجع idle، خليه success عشان listener ينقل
      // لو فشل، نرجّعه idle بعد عرض الرسالة (اختياري)
      if (state.status == LoginStatus.failure) {
        emit(state.copyWith(status: LoginStatus.idle));
      }
    }
  }

  // مفيد لو عايز Reset للفورم
  void reset() => emit(const LoginState());
}
