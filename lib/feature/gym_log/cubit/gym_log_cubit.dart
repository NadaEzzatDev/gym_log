import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/exercise_type.dart';
import '../data/models/workout_entry.dart';
import '../data/repositories/workout_repository.dart';
import 'gym_log_state.dart';
import 'motivation_message.dart';

class GymLogCubit extends Cubit<GymLogState> {
  final WorkoutRepository _repository;

  GymLogCubit(this._repository) : super(const GymLogInitial());

  void loadHistory() {
    final entries = _repository.getAllWorkouts();
    emit(GymLogLoaded(
      selectedExercises: {},
      history: entries,
    ));
  }

  void toggleExercise(ExerciseType exercise) {
    final currentState = state;
    if (currentState is! GymLogLoaded && currentState is! GymLogSaved) return;

    final selected = Set<ExerciseType>.from(state.selectedExercises);
    if (selected.contains(exercise)) {
      selected.remove(exercise);
    } else {
      selected.add(exercise);
    }

    emit(GymLogLoaded(
      selectedExercises: selected,
      history: state.history,
    ));
  }

  Future<void> saveWorkout() async {
    if (state.selectedExercises.isEmpty) return;

    final entry = WorkoutEntry(
      date: DateTime.now(),
      exercises: state.selectedExercises.toList(),
    );

    await _repository.addWorkout(entry);

    final entries = _repository.getAllWorkouts();
    final randomMessage =
        motivationMessages[Random().nextInt(motivationMessages.length)];

    emit(GymLogSaved(
      selectedExercises: {},
      history: entries,
      motivationMessage: randomMessage,
    ));
  }

  void dismissMessage() {
    emit(GymLogLoaded(
      selectedExercises: {},
      history: state.history,
    ));
  }

  Future<void> deleteWorkout(WorkoutEntry entry) async {
    await _repository.deleteWorkout(entry);

    final entries = _repository.getAllWorkouts();

    emit(GymLogLoaded(
      selectedExercises: state.selectedExercises,
      history: entries,
    ));
  }
}
