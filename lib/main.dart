import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:machinfy_agent/core/theme/app_theme.dart';
import 'package:machinfy_agent/core/theme/theme_provider.dart';
import 'package:machinfy_agent/firebase_options.dart';

import 'package:machinfy_agent/features/profile/cubit/profile/profile_cubit.dart';
import 'package:machinfy_agent/features/welcome_screen/presentation/view/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProfileCubit(
              auth: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
