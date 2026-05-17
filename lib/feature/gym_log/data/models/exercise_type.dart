import 'package:hive/hive.dart';

part 'exercise_type.g.dart';

@HiveType(typeId: 0)
enum ExerciseType {
  @HiveField(0)
  arms('💪', 'دراعات'),
  @HiveField(1)
  legs('🦵', 'رجلين'),
  @HiveField(2)
  chest('🏋️', 'صدر'),
  @HiveField(3)
  cardio('🏃', 'كارديو'),
  @HiveField(4)
  core('🔥', 'بطن');

  final String emoji;
  final String label;

  const ExerciseType(this.emoji, this.label);
}
