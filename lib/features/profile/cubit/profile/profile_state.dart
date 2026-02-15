import 'package:equatable/equatable.dart';

enum ProfileStatus { idle, loading, success, failure }

class ProfileState extends Equatable {
  final String uid;
  final String name;
  final String email;

  final bool hydrated; // هل جت بيانات من Firebase/Firestore؟
  final ProfileStatus status;
  final String? message;

  const ProfileState({
    this.uid = '',
    this.name = '',
    this.email = '',

    this.hydrated = false,
    this.status = ProfileStatus.idle,
    this.message,
  });

  bool get isLoading => status == ProfileStatus.loading;

  ProfileState copyWith({
    String? uid,
    String? name,
    String? email,

    bool? hydrated,
    ProfileStatus? status,
    String? message,
    bool clearMessage = false,
  }) {
    return ProfileState(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,

      hydrated: hydrated ?? this.hydrated,
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [uid, name, email, hydrated, status, message];
}
