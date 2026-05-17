import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/repositories/hive_workout_repository.dart';
import 'data/repositories/workout_repository.dart';
import 'models/exercise_type.dart';
import 'models/workout_entry.dart';
import 'cubit/gym_log_cubit.dart';
import 'screens/gym_log_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseTypeAdapter());
  Hive.registerAdapter(WorkoutEntryAdapter());

  final workoutBox = await Hive.openBox<WorkoutEntry>('workouts');
  final WorkoutRepository repository = HiveWorkoutRepository(workoutBox);

  runApp(GymLogApp(repository: repository));
}

class GymLogApp extends StatelessWidget {
  final WorkoutRepository repository;

  const GymLogApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GymLogCubit(repository)..loadHistory(),
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
