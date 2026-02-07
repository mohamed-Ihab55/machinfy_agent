import 'package:equatable/equatable.dart';

enum RegisterStatus { idle, loading, success, failure }

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  final bool isPasswordHidden;
  final bool isConfirmHidden;
  final bool acceptTerms;

  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmError;
  final String? termsError;

  final RegisterStatus status;
  final String? message;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordHidden = true,
    this.isConfirmHidden = true,
    this.acceptTerms = false,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmError,
    this.termsError,
    this.status = RegisterStatus.idle,
    this.message,
  });

  bool get isLoading => status == RegisterStatus.loading;

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isPasswordHidden,
    bool? isConfirmHidden,
    bool? acceptTerms,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmError,
    String? termsError,
    RegisterStatus? status,
    String? message,
    bool clearErrors = false,
    bool clearMessage = false,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isConfirmHidden: isConfirmHidden ?? this.isConfirmHidden,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      nameError: clearErrors ? null : (nameError ?? this.nameError),
      emailError: clearErrors ? null : (emailError ?? this.emailError),
      passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
      confirmError: clearErrors ? null : (confirmError ?? this.confirmError),
      termsError: clearErrors ? null : (termsError ?? this.termsError),
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    isPasswordHidden,
    isConfirmHidden,
    acceptTerms,
    nameError,
    emailError,
    passwordError,
    confirmError,
    termsError,
    status,
    message,
  ];
}
