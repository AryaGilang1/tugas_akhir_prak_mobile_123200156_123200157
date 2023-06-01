import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../api/database.dart';
import '../../size-config.dart';
import '../../utils/dialog_box.dart';
import '../../utils/todo_tile.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  static String routeName = '/todo-list';

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(20),
                ),
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: createNewTask, child: Text('Tambah')),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: db.toDoList.length,
                      itemBuilder: (context, index) {
                        return ToDoTile(
                          taskName: db.toDoList[index][0],
                          taskCompleted: db.toDoList[index][1],
                          onChanged: (value) => checkBoxChanged(value, index),
                          deleteFunction: (context) => deleteTask(index),
                        );
                      },
                    ),
                  )
                ])))));
  }
}
