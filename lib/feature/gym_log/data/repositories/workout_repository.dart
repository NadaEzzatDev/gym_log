
import '../models/workout_entry.dart';

abstract class WorkoutRepository {
  List<WorkoutEntry> getAllWorkouts();
  Future<void> addWorkout(WorkoutEntry entry);
  Future<void> deleteWorkout(WorkoutEntry entry);
}
