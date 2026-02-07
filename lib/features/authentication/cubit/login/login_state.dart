import 'package:equatable/equatable.dart';

enum LoginStatus { idle, loading, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;

  final bool rememberMe;
  final bool isPasswordHidden;

  final String? emailError;
  final String? passwordError;

  final LoginStatus status;
  final String? message;

  const LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isPasswordHidden = true,
    this.emailError,
    this.passwordError,
    this.status = LoginStatus.idle,
    this.message,
  });

  bool get isLoading => status == LoginStatus.loading;

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isPasswordHidden,
    String? emailError,
    String? passwordError,
    LoginStatus? status,
    String? message,
    bool clearErrors = false,
    bool clearMessage = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      emailError: clearErrors ? null : (emailError ?? this.emailError),
      passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    rememberMe,
    isPasswordHidden,
    emailError,
    passwordError,
    status,
    message,
  ];
}
