import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/setup_service_locator.dart';
import 'feature/gym_log/cubit/gym_log_cubit.dart';
import 'feature/gym_log/data/repositories/workout_repository.dart';
import 'feature/gym_log/screens/gym_log_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const GymLogApp());
}

class GymLogApp extends StatelessWidget {
  const GymLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GymLogCubit(
        getit<WorkoutRepository>(),
      )..loadHistory(),
      child: MaterialApp(
        title: 'Gym Log',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0D0D1A),
          fontFamily: 'Fredoka',
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF6366F1),
            secondary: Color(0xFFEC4899),
            surface: Color(0xFF1A1A2E),
          ),
        ),
        home: const GymLogScreen(),
      ),
    );
  }
}
