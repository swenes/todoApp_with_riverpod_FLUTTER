import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_with_riverpod/providers/all_providers.dart';
import 'package:to_do_with_riverpod/widgets/list_item_widget.dart';
import 'package:to_do_with_riverpod/widgets/title_widget.dart';
import 'package:to_do_with_riverpod/widgets/tool_bar_widget.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            decoration:
                const InputDecoration(labelText: 'Bugün Neler Yapacaksın ?'),
            onSubmitted: (newToDo) {
              ref.read(todoListProvider.notifier).addTodo(newToDo);
            },
          ),
          const SizedBox(height: 20),
          ToolBarWidget(),
          if (allTodos.isEmpty)
            const Center(
              child: Text('Bu koşul için herhangi bir görev yok'),
            )
          else
            const SizedBox(),
          for (int i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).remove(allTodos[i]);
              },
              child: ProviderScope(
                overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i]),
                ],
                child: const ListItemWidget(),
              ),
            )
        ],
      ),
    );
  }
}
