


import 'package:flutter/cupertino.dart';


import '../Models/TodoModel.dart';



@immutable
abstract class todoevent {}

class LoadTodos extends todoevent{}

class AddTodo extends todoevent{
  final TodoModel todo;
  AddTodo(this.todo);
}

class UpdateTodo extends todoevent{
  final TodoModel todo;
  UpdateTodo(this.todo);

}

class DeleteTodo extends todoevent{
  final String todo;

  DeleteTodo(this.todo);

}