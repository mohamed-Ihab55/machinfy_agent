import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Check if device supports biometrics
  Future<bool> isSupported() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      return canCheck || isSupported;
    } on PlatformException {
      return false;
    }
  }

  /// Get available biometric types (fingerprint / face)
  Future<List<BiometricType>> availableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    }
  }

  /// Check if any credentials (biometric or device passcode) exist
  Future<bool> hasCredentials() async {
    final available = await availableBiometrics();
    return available.isNotEmpty;
  }

  /// Authenticate user (biometric only if available)
  Future<bool> authenticate() async {
    try {
      final isSupported = await this.isSupported();
      final hasCreds = await this.hasCredentials();

      if (!isSupported || !hasCreds) {
        print('No biometrics or credentials set on device.');
        return false;
      }

      final authenticated = await _auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        biometricOnly: true,
      );

      return authenticated;
    } on PlatformException catch (e) {
      print('Authentication error: ${e.code} - ${e.message}');
      return false;
    }
  }

  /// Authenticate with fallback to device credentials (PIN/Password)
  Future<bool> authenticateWithFallback() async {
    try {
      final isSupported = await this.isSupported();
      final hasCreds = await this.hasCredentials();

      if (!isSupported || !hasCreds) {
        print('No credentials available for authentication.');
        return false;
      }

      final authenticated = await _auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        biometricOnly: false, // allows PIN/Password fallback
      );

      return authenticated;
    } on PlatformException catch (e) {
      print('Authentication error: ${e.code} - ${e.message}');
      return false;
    }
  }

  /// Get biometric type name for display
  Future<String> getBiometricTypeName() async {
    final available = await availableBiometrics();

    if (available.contains(BiometricType.face)) {
      return 'Face ID';
    } else if (available.contains(BiometricType.fingerprint)) {
      return 'Fingerprint';
    } else if (available.contains(BiometricType.iris)) {
      return 'Iris';
    } else {
      return 'No biometric available';
    }
  }

  /// Stop ongoing authentication
  Future<void> stopAuthentication() async {
    try {
      await _auth.stopAuthentication();
    } catch (e) {
      print('Error stopping authentication: $e');
    }
  }

  /// Specific checks
  Future<bool> isFaceIdAvailable() async {
    final available = await availableBiometrics();
    return available.contains(BiometricType.face);
  }

  Future<bool> isFingerprintAvailable() async {
    final available = await availableBiometrics();
    return available.contains(BiometricType.fingerprint);
  }
}
