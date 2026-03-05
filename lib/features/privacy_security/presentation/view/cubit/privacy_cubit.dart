import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/features/privacy_security/presentation/view/service/biometric_service.dart';
import 'package:machinfy_agent/features/privacy_security/presentation/view/service/setting_service.dart';
import 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  final SettingsService settings;
  final BiometricService biometrics;

  PrivacyCubit(this.settings, this.biometrics) : super(const PrivacyState());

  Future<void> init() async {
    final twoFactor = await settings.getTwoFactor();
    final biometric = await settings.getBiometric();
    final activity = await settings.getActivityStatus();
    final supported = await biometrics.isSupported();

    emit(
      state.copyWith(
        loading: false,
        twoFactor: twoFactor,
        biometric: biometric,
        activityStatus: activity,
        biometricSupported: supported,
      ),
    );
  }

  Future<void> toggle2FA(bool value) async {
    await settings.setTwoFactor(value);
    emit(state.copyWith(twoFactor: value));
  }

  Future<void> toggleActivity(bool value) async {
    await settings.setActivityStatus(value);
    emit(state.copyWith(activityStatus: value));
  }

  Future<bool> toggleBiometric(bool value) async {

  if (value) {
    final auth = await biometrics.authenticateWithFallback();
    if (!auth) return false; 
  }

  await settings.setBiometric(value);
  emit(state.copyWith(biometric: value));
  return true;
}
}