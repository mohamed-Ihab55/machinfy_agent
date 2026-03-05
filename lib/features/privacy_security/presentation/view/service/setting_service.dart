import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<bool> getTwoFactor() async {
    final p = await _prefs;
    return p.getBool('twoFactorAuth') ?? false;
  }

  Future<bool> getBiometric() async {
    final p = await _prefs;
    return p.getBool('biometricLogin') ?? false;
  }

  Future<bool> getActivityStatus() async {
    final p = await _prefs;
    return p.getBool('activityStatus') ?? true;
  }

  Future<void> setTwoFactor(bool value) async {
    final p = await _prefs;
    await p.setBool('twoFactorAuth', value);
  }

  Future<void> setBiometric(bool value) async {
    final p = await _prefs;
    await p.setBool('biometricLogin', value);
  }

  Future<void> setActivityStatus(bool value) async {
    final p = await _prefs;
    await p.setBool('activityStatus', value);
  }
}