
class TodoModel{
  String id ;
  String task;
  String description;
  String addTag;

  TodoModel({required this.id, required this.task,required this.description, required this.addTag});

  // TodoModel copyWith({
  //   String? id,
  //   String? task,
  //   String? description,
  //   String? addTag,
  // }) {
  //   return TodoModel(
  //     id: id ?? this.id,
  //     task: task?? this.task,
  //     description: description ?? this.description,
  //     addTag: addTag ?? this.addTag,
  //
  //   );
  //}
}