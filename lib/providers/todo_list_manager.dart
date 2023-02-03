import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_with_riverpod/models/to_do_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<ToDoModel>> {
  TodoListManager([List<ToDoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    var eklenecekTodo =
        (ToDoModel(id: const Uuid().v4(), description: description));

    state = [...state, eklenecekTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          ToDoModel(
              id: todo.id,
              description: todo.description,
              completed: !todo.completed)
        else
          todo,
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          ToDoModel(
              id: todo.id,
              description: newDescription,
              completed: todo.completed)
        else
          todo
    ];
  }

  void remove(ToDoModel silinecekTodo) {
    state = state.where((element) => element.id != silinecekTodo.id).toList();
  }

  int unCompletedCount() {
    return state.where((element) => !element.completed).length;
  }
}
