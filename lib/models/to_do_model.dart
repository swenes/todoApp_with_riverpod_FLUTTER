class ToDoModel {
  final String id;
  final String description;
  final bool completed;

  ToDoModel(
      {required this.id, required this.description, this.completed = false});
}
