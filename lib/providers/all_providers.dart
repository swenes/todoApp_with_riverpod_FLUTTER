import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_with_riverpod/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/to_do_model.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter = StateProvider<TodoListFilter>((ref) {
  return TodoListFilter.all;
});

final filteredTodoList = Provider<List<ToDoModel>>(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final todoList = ref.watch(todoListProvider);

    switch (filter) {
      case TodoListFilter.all:
        return todoList;
      case TodoListFilter.completed:
        return todoList.where((element) => element.completed).toList();
      case TodoListFilter.active:
        return todoList.where((element) => !element.completed).toList();
    }
  },
);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<ToDoModel>>((ref) {
  return TodoListManager([
    ToDoModel(id: const Uuid().v4(), description: 'Spora Git'),
    ToDoModel(id: const Uuid().v4(), description: 'Yemek Ye'),
    ToDoModel(id: const Uuid().v4(), description: 'Alışveriş Yap'),
    ToDoModel(id: const Uuid().v4(), description: 'Flutter Çalış'),
  ]);
});

final unCompletedCountProvider = Provider<int>((ref) {
  var allTodos = ref.watch(todoListProvider);
  var count = allTodos.where((element) => !element.completed).length;
  return count;
});

final currentTodoProvider = Provider<ToDoModel>((ref) {
  throw UnimplementedError();
});
