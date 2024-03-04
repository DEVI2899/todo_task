import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/todobloc.dart';

import '../Bloc/todoevent.dart';
import '../Bloc/todostate.dart';
import '../Models/TodoModel.dart';

class UpdateTodos extends StatefulWidget {
  final TodoModel todoModel;
  const UpdateTodos({super.key, required this.todoModel});

  @override
  State<UpdateTodos> createState() => _UpdateTodosState();
}

class _UpdateTodosState extends State<UpdateTodos> {
  TextEditingController? _taskNameController ;
  TextEditingController? _taskDescController;
  // final TextEditingController taskNameController = TextEditingController();
  // final TextEditingController taskDescController = TextEditingController();
  final List<String> taskTags = ['Task1', 'Task2', 'Other'];
  String selectedValue = '';

  @override
  void initState(){
     super.initState();
     setState(() {
       _taskNameController =TextEditingController(text: widget.todoModel.task);
       _taskDescController =TextEditingController(text: widget.todoModel.description);
     });


  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: height *0.30,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _taskNameController,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Task',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.square_list, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  const Icon(CupertinoIcons.tag, color: Colors.brown),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                     // value: widget.todoModel.addTag,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: 200,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      isExpanded: true,
                      hint: const Text('update a task tag',
                        style: TextStyle(fontSize: 14),
                      ),

                      items: taskTags.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: const TextStyle(fontSize: 14,),
                        ),
                      ),
                      )
                          .toList(),
                      onChanged: (String? value) => setState(() {
                        if (value != null) selectedValue = value;
                      },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)
              )
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.white),),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)
              )
          ),
          onPressed: () {

            final todo =TodoModel(
                id: widget.todoModel.id,
                task: _taskNameController!.text,
                description: _taskDescController!.text,
                addTag: widget.todoModel.addTag

            );
            // var taskTag = '';
            // selectedValue == '' ? taskTag = widget.addTag : taskTag = selectedValue;
            BlocProvider.of<TodoBloc>(context).add(UpdateTodo(todo));
            ClearText();
            Navigator.pop(context);
          },
          child: const Text('update',style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
  void ClearText(){
    _taskNameController!.dispose();
    _taskDescController!.dispose();
  }
}
