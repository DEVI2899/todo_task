import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/TodoModel.dart';



class TodoService {
  final CollectionReference _todosCollection = FirebaseFirestore.instance.collection('todos');

  Stream<List<TodoModel>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TodoModel(
          id: doc.id,
          task: data['task'],
          description: data['description'],
          addTag: data['addTag'],
        );
      }).toList();
    });
  }

  Future<void> addTodo(TodoModel todo) {
    return _todosCollection.add({
      'task': todo.task,
      'description':todo.description,
      'addTag': todo.addTag,
    });
  }

  Future<void> updateTodo(TodoModel todo) {
    return _todosCollection.doc(todo.id).update({
      'task': todo.task,
      'description':todo.description,
      'addTag': todo.addTag,
    });
  }

  Future<void> deleteTodo(String todoId) {
    return _todosCollection.doc(todoId).delete();
  }
}