
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../feature/gym_log/data/models/exercise_type.dart';
import '../feature/gym_log/data/models/workout_entry.dart';
import '../feature/gym_log/data/repositories/hive_workout_repository.dart';
import '../feature/gym_log/data/repositories/workout_repository.dart';

final getit = GetIt.instance;

Future<void> setupServiceLocator()async {
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseTypeAdapter());
  Hive.registerAdapter(WorkoutEntryAdapter());

  final workoutBox = await Hive.openBox<WorkoutEntry>('workouts');

  // Repository
  getit.registerLazySingleton<WorkoutRepository>(
        () => HiveWorkoutRepository(workoutBox),
  );

}
