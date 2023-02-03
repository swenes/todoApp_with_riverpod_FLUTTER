import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_with_riverpod/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({super.key});

  TodoListFilter currentFilter = TodoListFilter.all;

  Color changeColor(TodoListFilter filt) {
    return currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unCompletedCount = ref.watch(unCompletedCountProvider);
    currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          unCompletedCount == 0
              ? 'Tüm görevler tamamlandı'
              : '$unCompletedCount görev tamamlanmadı',
          textAlign: TextAlign.center,
        )),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: changeColor(TodoListFilter.all)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.all;
              },
              child: const Text('All')),
        ),
        Tooltip(
          message: 'Active Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: changeColor(TodoListFilter.active)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.active;
              },
              child: const Text('Active')),
        ),
        Tooltip(
          message: 'Completed Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: changeColor(TodoListFilter.completed)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.completed;
              },
              child: const Text('Completed')),
        )
      ],
    );
  }
}
