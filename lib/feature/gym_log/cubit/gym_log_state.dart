import '../data/models/exercise_type.dart';
import '../data/models/workout_entry.dart';

sealed class GymLogState {
  final Set<ExerciseType> selectedExercises;
  final List<WorkoutEntry> history;

  const GymLogState({
    required this.selectedExercises,
    required this.history,
  });
}

class GymLogInitial extends GymLogState {
  const GymLogInitial()
      : super(
          selectedExercises: const {},
          history: const [],
        );
}

class GymLogLoaded extends GymLogState {
  const GymLogLoaded({
    required super.selectedExercises,
    required super.history,
  });

  GymLogLoaded copyWith({
    Set<ExerciseType>? selectedExercises,
    List<WorkoutEntry>? history,
  }) {
    return GymLogLoaded(
      selectedExercises: selectedExercises ?? this.selectedExercises,
      history: history ?? this.history,
    );
  }
}

class GymLogSaved extends GymLogState {
  final String motivationMessage;

  const GymLogSaved({
    required super.selectedExercises,
    required super.history,
    required this.motivationMessage,
  });
}
