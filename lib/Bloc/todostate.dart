


import 'package:flutter/material.dart';


import '../Models/TodoModel.dart';



@immutable

abstract class TodoState{}

class TodoInitial extends TodoState{}

class TodoLoading extends TodoState{}

class TodoLoaded extends TodoState{
  final List<TodoModel>? todos;
  TodoLoaded(this.todos);
}

class TodoSuccess extends TodoState{
  final String? message;
  TodoSuccess(this.message);
}

class TodoError extends TodoState{
  final String? errormessage;
  TodoError(this.errormessage);
}