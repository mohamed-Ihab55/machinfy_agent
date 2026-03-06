import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore,
       super(const ProfileState());

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  StreamSubscription<User?>? _authSub;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _profileSub;

  /// Start listening to auth + profile changes
  void start() {
    _authSub?.cancel();
    _authSub = _auth.userChanges().listen(_onUserChanged);

    _onUserChanged(_auth.currentUser);
  }

  Future<void> _onUserChanged(User? user) async {
    await _profileSub?.cancel();

    if (user == null) {
      emit(const ProfileState());
      return;
    }

    /// Fallback data from FirebaseAuth
    emit(
      state.copyWith(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        hydrated: true,
        clearMessage: true,
      ),
    );

    final docRef = _firestore.collection('users').doc(user.uid);

    /// Ensure document exists
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    /// Listen to Firestore profile updates
    _profileSub = docRef.snapshots().listen((snap) {
      final data = snap.data();
      if (data == null) return;

      emit(
        state.copyWith(
          uid: user.uid,
          name: (data['name'] as String?) ?? user.displayName ?? '',
          email: (data['email'] as String?) ?? user.email ?? '',
          hydrated: true,
        ),
      );
    });
  }

  /// Handle name change in UI
  void nameChanged(String value) {
    emit(state.copyWith(name: value, clearMessage: true));
  }

  /// Email usually read-only
  void emailChanged(String value) {
    emit(state.copyWith(email: value, clearMessage: true));
  }

  /// Generate user initials
  String initials() {
    final name = state.name.trim();
    if (name.isEmpty) return 'U';

    final parts = name
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();

    final first = parts[0][0];
    final second = parts.length > 1 ? parts[1][0] : '';

    return (first + second).toUpperCase();
  }

  /// Save profile changes
  Future<void> saveChanges() async {
    emit(state.copyWith(status: ProfileStatus.loading, clearMessage: true));

    try {
      final user = _auth.currentUser;

      if (user == null) {
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            message: 'No user logged in',
          ),
        );
        return;
      }

      final name = state.name.trim();

      /// Update FirebaseAuth profile
      await user.updateDisplayName(name);
      await user.reload();

      /// Update Firestore profile
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': user.email,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          message: 'Profile updated successfully',
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          message: 'Auth error: ${e.code}',
        ),
      );
    } on FirebaseException catch (e, st) {
      debugPrint('Firestore error: ${e.code}');
      debugPrint('Message: ${e.message}');
      debugPrintStack(stackTrace: st);

      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          message: 'Firestore: ${e.code}',
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _authSub?.cancel();
    await _profileSub?.cancel();
    return super.close();
  }
}
