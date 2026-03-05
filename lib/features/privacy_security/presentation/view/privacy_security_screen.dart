import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/features/privacy_security/presentation/view/cubit/privacy_cubit.dart';
import 'package:machinfy_agent/features/privacy_security/presentation/view/cubit/privacy_state.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/switch_setting_tile.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivacyCubit, PrivacyState>(
      builder: (context, state) {
        if (state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final cubit = context.read<PrivacyCubit>();

        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy & Security"),
            centerTitle: true,
            // backgroundColor: ThemeData
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SwitchSettingTile(
                icon: Icons.security_outlined,
                title: "Two Factor Authentication",
                subtitle: 'Add extra security to your account',
                value: state.twoFactor,
                onChanged: cubit.toggle2FA,
              ),

              SwitchSettingTile(
                icon: Icons.fingerprint_outlined,
                title: "Biometric Login",
                subtitle: state.biometricSupported
                    ? "Use fingerprint or face recognition to log in"
                    : "Your device does not support biometric authentication",
                value: state.biometric,
                onChanged: state.biometricSupported
                    ? (value) {
                        cubit.toggleBiometric(value).then((success) {
                          if (!success && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Biometric authentication failed or canceled.',
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        });
                      }
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
