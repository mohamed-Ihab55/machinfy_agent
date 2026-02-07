import 'package:equatable/equatable.dart';

enum ResetPasswordStatus { idle, loading, success, failure }

class ResetPasswordState extends Equatable {
  final String email;
  final String? emailError;

  final ResetPasswordStatus status;
  final String? message;

  const ResetPasswordState({
    this.email = '',
    this.emailError,
    this.status = ResetPasswordStatus.idle,
    this.message,
  });

  bool get isLoading => status == ResetPasswordStatus.loading;

  ResetPasswordState copyWith({
    String? email,
    String? emailError,
    ResetPasswordStatus? status,
    String? message,
    bool clearError = false,
    bool clearMessage = false,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      emailError: clearError ? null : (emailError ?? this.emailError),
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [email, emailError, status, message];
}
