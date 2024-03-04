
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Bloc/todoevent.dart';
import 'package:task/Bloc/todostate.dart';
import 'package:task/service/todoservice.dart';



class TodoBloc extends Bloc<todoevent, TodoState>{
  final TodoService _todoService ;
  TodoBloc(this._todoService):super(TodoInitial()){

    on<LoadTodos>((event, emit) async {
      try {
        emit(TodoLoading());
        final todos = await _todoService.getTodos().first;
        emit(TodoLoaded(todos));
      }
      catch (e){
        emit(TodoError('Failed to get todos'));
      }
    });
    on<AddTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _todoService.addTodo(event.todo);
        emit(TodoSuccess('Todo added successfully.'));
      } catch (e) {
        emit(TodoError('Failed to add todo.'));
      }
    });

    on<UpdateTodo>((event, emit)  async {
      try {
        emit(TodoLoading());
        await _todoService.updateTodo(event.todo);
        emit(TodoSuccess('Todo updated successfully.'));
      } catch (e) {
        emit(TodoError('Failed to update todo.'));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _todoService.deleteTodo(event.todo);
        emit(TodoSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(TodoError('Failed to delete todo.'));
      }
    });

  }
}

