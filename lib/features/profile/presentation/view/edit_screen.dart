import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:machinfy_agent/features/profile/cubit/profile/profile_cubit.dart';
import 'package:machinfy_agent/features/profile/presentation/widgets/edit_profile_body.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: const ProfileBody(),
    );
  }
}
