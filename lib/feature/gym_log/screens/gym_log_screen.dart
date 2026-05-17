import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_log/feature/gym_log/screens/widgets/bravo_video_dialog.dart';
import 'package:gym_log/feature/gym_log/screens/widgets/exercise_grid.dart';
import 'package:gym_log/feature/gym_log/screens/widgets/history_list.dart';
import '../cubit/gym_log_cubit.dart';
import '../cubit/gym_log_state.dart';

class GymLogScreen extends StatelessWidget {
  const GymLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GymLogCubit, GymLogState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0D0D1A),
                      Color(0xFF1A1A2E),
                      Color(0xFF16213E),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      _buildTitle(),
                      const SizedBox(height: 24),
                      HistoryList(
                        history: state.history,
                        onDelete: (entry) => context.read<GymLogCubit>().deleteWorkout(entry),
                      ),
                      const SizedBox(height: 24),
                      _buildQuestion(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ExerciseGrid(
                          selectedExercises: state.selectedExercises,
                          onToggle: (exercise) => context.read<GymLogCubit>().toggleExercise(exercise),
                        ),
                      ),
                      _buildSaveButton(context, state.selectedExercises.isNotEmpty),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              if (state is GymLogSaved)
                BravoVideoDialog(
                  message: state.motivationMessage,
                  onDismiss: () => context.read<GymLogCubit>().dismissMessage(),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
      ).createShader(bounds),
      child: const Text(
        'GYM LOG',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 4,
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'لعبت ايه النهارده؟',
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, bool hasSelection) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: hasSelection ? 1.0 : 0.4,
        child: GestureDetector(
          onTap: hasSelection
              ? () => context.read<GymLogCubit>().saveWorkout()
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 56,
            decoration: BoxDecoration(
              gradient: hasSelection
                  ? const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                    )
                  : null,
              color: hasSelection ? null : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(16),
              boxShadow: hasSelection
                  ? [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'سجّل تمرين النهارده',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
