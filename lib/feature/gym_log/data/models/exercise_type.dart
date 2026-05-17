import 'package:hive/hive.dart';

part 'exercise_type.g.dart';

@HiveType(typeId: 0)
enum ExerciseType {
  @HiveField(0)
  arms('💪', 'Arms'),
  @HiveField(1)
  legs('🦵', 'Legs'),
  @HiveField(2)
  chest('🏋️', 'Chest'),
  @HiveField(3)
  cardio('🏃', 'Cardio'),
  @HiveField(4)
  core('🔥', 'Core');

  final String emoji;
  final String label;

  const ExerciseType(this.emoji, this.label);
}
