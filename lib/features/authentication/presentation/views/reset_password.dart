import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:machinfy_agent/features/authentication/cubit/reset_password/reset_password_cubit.dart';
import 'package:machinfy_agent/features/authentication/presentation/widgets/reset_password_body.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(),
      child: const ResetPasswordBody(),
    );
  }
}
