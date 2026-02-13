// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:machinfy_agent/features/authentication/data/remember_me_storage.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState()) {
    _loadRememberPrefs();
  }
  Future<void> _loadRememberPrefs() async {
    final remember = await RememberMeStorage.getRememberMe();
    final savedEmail = await RememberMeStorage.getRememberEmail();

    emit(
      state.copyWith(
        rememberMe: remember,
        // لو remember شغال وفيه ايميل محفوظ -> حطه في state.email
        email: (remember && savedEmail != null) ? savedEmail : state.email,
      ),
    );
  }

  // بدل controllers: UI تبعت القيم هنا
  void emailChanged(String value) {
    emit(state.copyWith(email: value, emailError: null, clearMessage: true));
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(password: value, passwordError: null, clearMessage: true),
    );
  }

  Future<void> toggleRememberMe(bool? value) async {
    final v = value ?? false;

    emit(state.copyWith(rememberMe: v));

    await RememberMeStorage.setRememberMe(v);

    // لو المستخدم قفل Remember me -> امسح الايميل المحفوظ
    if (!v) {
      await RememberMeStorage.clearRememberEmail();
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  bool _validate() {
    final email = state.email.trim();
    final pass = state.password;

    String? emailError;
    String? passwordError;

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
      // placeholder
      await Future.delayed(const Duration(seconds: 2));

      // ✅ احفظ/امسح الايميل حسب rememberMe (بعد نجاح تسجيل الدخول)
      if (state.rememberMe) {
        await RememberMeStorage.setRememberEmail(state.email.trim());
      } else {
        await RememberMeStorage.clearRememberEmail();
      }

      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          message: 'Login failed, please try again',
        ),
      );
    } finally {
      if (state.status == LoginStatus.failure) {
        emit(state.copyWith(status: LoginStatus.idle));
      }
    }
  }

  void reset() => emit(const LoginState());
}
