import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Box<String>? todoBox;

  final _keyName = TextEditingController();
  final _tasName = TextEditingController();

  @override
  void initState() {
    todoBox = Hive.box<String>("todos");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Text("ADD TASK"),
                    TextFormField(
                      controller: _keyName,
                      decoration: InputDecoration(hintText: "Enter key name"),
                    ),
                    TextFormField(
                      controller: _tasName,
                      decoration: InputDecoration(hintText: "Enter task name"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () async {
                        await todoBox!.put(_keyName.text, _tasName.text);
                        Navigator.pop(context);
                        _keyName.clear();
                        _tasName.clear();
                      },
                      child: Text("Add")),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox!.listenable(),
        builder: (BuildContext context, Box<String> todos, _) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final key = todos.keys.toList()[index];
              final value = todoBox!.get(key);
              return ListTile(
                title: Text(
                  value!,
                  textScaleFactor: 1,
                ),
                subtitle: Text(
                  key,
                  textScaleFactor: 1,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Column(
                                children: [
                                  Text("UPDATE TASK"),
                                  TextFormField(
                                    controller: _keyName,
                                    decoration: InputDecoration(
                                        hintText: "Enter key name"),
                                  ),
                                  TextFormField(
                                    controller: _tasName,
                                    decoration: InputDecoration(
                                        hintText: "Enter task name"),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                    onPressed: () async {
                                      await todoBox!.put(key,
                                          _keyName.text + "\n" + _tasName.text);
                                      Navigator.pop(context);
                                      _keyName.clear();
                                      _tasName.clear();
                                    },
                                    child: Text("Update")),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Do you want to delete it ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No")),
                                  TextButton(
                                      onPressed: () async {
                                        await todoBox!.delete(key);

                                        Navigator.pop(context);
                                      },
                                      child: Text("Yes"))
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
