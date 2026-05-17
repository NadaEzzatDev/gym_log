import 'package:hive/hive.dart';
import '../../models/workout_entry.dart';
import 'workout_repository.dart';

class HiveWorkoutRepository implements WorkoutRepository {
  final Box<WorkoutEntry> _box;

  HiveWorkoutRepository(this._box);

  @override
  List<WorkoutEntry> getAllWorkouts() {
    final entries = _box.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }

  @override
  Future<void> addWorkout(WorkoutEntry entry) async {
    await _box.add(entry);
  }

  @override
  Future<void> deleteWorkout(WorkoutEntry entry) async {
    await entry.delete();
  }
}
