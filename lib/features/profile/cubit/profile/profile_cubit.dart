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

  void start() {
    _authSub?.cancel();
    _authSub = _auth.userChanges().listen(_onUserChanged);
    // يشتغل فورًا على currentUser لو موجود:
    _onUserChanged(_auth.currentUser);
  }

  Future<void> _onUserChanged(User? user) async {
    await _profileSub?.cancel();

    if (user == null) {
      emit(const ProfileState()); // رجّع state فاضي عند logout
      return;
    }

    // قيم مبدئية من Auth (fallback)
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

    // لو أول مرة، اعمل doc مبدئي
    await docRef.set({
      'name': user.displayName ?? '',
      'email': user.email ?? '',

      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    _profileSub = docRef.snapshots().listen((snap) {
      final data = snap.data();
      if (data == null) return;

      emit(
        state.copyWith(
          uid: user.uid,
          name: (data['name'] as String?) ?? (user.displayName ?? ''),
          email: (data['email'] as String?) ?? (user.email ?? ''),

          hydrated: true,
        ),
      );
    });
  }

  void nameChanged(String v) =>
      emit(state.copyWith(name: v, clearMessage: true));
  // الأفضل نخلي الإيميل read-only في الـ UI (هشرح تحت)
  void emailChanged(String v) =>
      emit(state.copyWith(email: v, clearMessage: true));

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

  Future<void> saveChanges() async {
    emit(state.copyWith(status: ProfileStatus.loading, clearMessage: true));

    try {
      final user = FirebaseAuth.instance.currentUser;
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

      // ✅ طالما الإيميل هتسيبيه read-only: متحاوليش updateEmail خالص
      await user.updateDisplayName(name);
      await user.reload();

      // ✅ حفظ Firestore (اللي هيخلّي كل الأب يسمع)
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'name': name,
          'email': user.email, // خدها من Auth
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      ); // merge موثق رسميًا :contentReference[oaicite:2]{index=2}

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
      debugPrint('FIRESTORE CODE: ${e.code}');
      debugPrint('FIRESTORE MESSAGE: ${e.message}');
      debugPrint('STACK: $st');

      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          message: 'Firestore: ${e.code} | ${e.message}',
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
