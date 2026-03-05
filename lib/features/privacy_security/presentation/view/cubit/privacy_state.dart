class PrivacyState {
  final bool loading;
  final bool twoFactor;
  final bool biometric;
  final bool activityStatus;
  final bool biometricSupported;

  const PrivacyState({
    this.loading = true,
    this.twoFactor = false,
    this.biometric = false,
    this.activityStatus = true,
    this.biometricSupported = false,
  });

  PrivacyState copyWith({
    bool? loading,
    bool? twoFactor,
    bool? biometric,
    bool? activityStatus,
    bool? biometricSupported,
  }) {
    return PrivacyState(
      loading: loading ?? this.loading,
      twoFactor: twoFactor ?? this.twoFactor,
      biometric: biometric ?? this.biometric,
      activityStatus: activityStatus ?? this.activityStatus,
      biometricSupported: biometricSupported ?? this.biometricSupported,
    );
  }
}