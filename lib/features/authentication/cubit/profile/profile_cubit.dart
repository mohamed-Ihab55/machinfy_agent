// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void nameChanged(String v) =>
      emit(state.copyWith(name: v, clearMessage: true));
  void emailChanged(String v) =>
      emit(state.copyWith(email: v, clearMessage: true));
  void phoneChanged(String v) =>
      emit(state.copyWith(phone: v, clearMessage: true));
  void bioChanged(String v) => emit(state.copyWith(bio: v, clearMessage: true));

  String initials() {
    final name = state.name.trim();
    if (name.isEmpty) return 'U';
    final parts = name
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();
    final first = parts.isNotEmpty ? parts[0][0] : 'U';
    final second = parts.length > 1 ? parts[1][0] : '';
    return (first + second).toUpperCase();
  }

  // placeholder
  void changePhoto() {
    emit(state.copyWith(message: 'Change photo clicked'));
  }

  Future<void> saveChanges() async {
    emit(state.copyWith(status: ProfileStatus.loading, clearMessage: true));

    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          message: 'Profile updated successfully',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          message: 'Failed to update profile',
        ),
      );
    } finally {
      // اختياري: رجّعها idle بعد ما تظهر الرسالة
      if (state.status != ProfileStatus.loading) {
        emit(state.copyWith(status: ProfileStatus.idle));
      }
    }
  }
}
