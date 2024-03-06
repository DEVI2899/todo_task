
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/todobloc.dart';
import '../Bloc/todoevent.dart';
import '../Bloc/todostate.dart';
import '../Models/TodoModel.dart';
import '../widgets/AlertDialog.dart';

import 'UpdateTodo.dart';



class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(LoadTodos());
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List',
          style: TextStyle(color:Colors.white, fontSize: 25,fontWeight: FontWeight.bold ),),
        centerTitle: true,
       backgroundColor: Colors.brown,
        actions:[
          IconButton(onPressed: () {  },
          icon: const Icon(Icons.calendar_month, color: Colors.white,),
        ),
    ]
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            final todos = state.todos;
            return ListView.builder(
              itemCount: todos?.length,
              itemBuilder: (context, index) {
                final todo = todos?[index];
                Color taskColor = Colors.green;
                var taskTagType = todo!.addTag;
                if (taskTagType == 'Task1') {
                  taskColor = Colors.blue;
                } else if (taskTagType == 'Task2') {
                  taskColor = Colors.pinkAccent;
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.white,
                    child: ListTile(
                      title: Text(todo!.task,
                        style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold,
                        color: Colors.black
                        ),
                      ),
                      subtitle: Text(todo.description,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),
                      ),

                      // leading: Text(todo.addTag),
                      leading:  Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        alignment: Alignment.center,
                        child:  CircleAvatar(
                         backgroundColor: taskColor,
                        ),
                      ),
                      iconColor: Colors.black,
                      trailing: PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              value: 'edit',
                              child: const Text(
                                'update',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        UpdateTodos(todoModel: TodoModel(id: todo.id, task: todo.task, description: todo.description, addTag: todo.addTag),),
                                  );
                              },
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: const Text(
                                'Delete',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              onTap: (){
                                todoBloc.add(DeleteTodo(todo.id));
                              },
                            ),
                          ];
                        },

                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TodoSuccess) {
            todoBloc.add(LoadTodos()); // Reload todos
            return Container(); // Or display a success message
          } else if (state is TodoError) {
            return Center(child: Text(state.errormessage!));
          } else {
            return Container();
          }
        },
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        elevation: 5,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
            const AddAlertDialog()
          );
          //_showAddTodoDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white60,
        shape: const CircularNotchedRectangle(

        ),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){
           //   const TodoListPage();
            }, icon: const Icon(Icons.list_alt_rounded, size: 30,) ),
            IconButton(onPressed: (){},
                icon: const Icon(CupertinoIcons.tag, size: 30,) ),
        ],),
      ),
    );
  }




}
