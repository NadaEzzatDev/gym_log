import 'package:flutter/material.dart';
import '../models/workout_entry.dart';
import 'history_item.dart';

class HistoryList extends StatefulWidget {
  final List<WorkoutEntry> history;
  final void Function(WorkoutEntry) onDelete;

  const HistoryList({
    super.key,
    required this.history,
    required this.onDelete,
  });

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(HistoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.history.length > oldWidget.history.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.history.isEmpty) {
      return Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF3D3D6B), width: 1),
        ),
        child: const Center(
          child: Text(
            'لسه مفيش تمارين - يلا نبدأ!',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3D3D6B), width: 1),
      ),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: widget.history.length,
        itemBuilder: (context, index) {
          final entry = widget.history[index];
          return HistoryItem(
            entry: entry,
            onDelete: () => widget.onDelete(entry),
          );
        },
      ),
    );
  }
}
