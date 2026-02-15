import 'package:equatable/equatable.dart';

enum ProfileStatus { idle, loading, success, failure }

class ProfileState extends Equatable {
  final String name;
  final String email;

  final ProfileStatus status;
  final String? message;

  const ProfileState({
    this.name = 'Ahmed Hassan',
    this.email = 'ahmed.hassan@email.com',

    this.status = ProfileStatus.idle,
    this.message,
  });

  bool get isLoading => status == ProfileStatus.loading;

  ProfileState copyWith({
    String? name,
    String? email,

    ProfileStatus? status,
    String? message,
    bool clearMessage = false,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,

      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [name, email, status, message];
}
