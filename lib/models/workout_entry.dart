import 'package:hive/hive.dart';
import 'exercise_type.dart';

part 'workout_entry.g.dart';

@HiveType(typeId: 1)
class WorkoutEntry extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final List<ExerciseType> exercises;

  WorkoutEntry({
    required this.date,
    required this.exercises,
  });
}
