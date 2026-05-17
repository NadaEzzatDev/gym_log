import 'package:flutter/material.dart';
import '../../data/models/exercise_type.dart';
import 'exercise_button.dart';

class ExerciseGrid extends StatelessWidget {
  final Set<ExerciseType> selectedExercises;
  final void Function(ExerciseType) onToggle;

  const ExerciseGrid({
    super.key,
    required this.selectedExercises,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: ExerciseType.values.map((exercise) {
          return ExerciseButton(
            exercise: exercise,
            isSelected: selectedExercises.contains(exercise),
            onTap: () => onToggle(exercise),
          );
        }).toList(),
      ),
    );
  }
}
