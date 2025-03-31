import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:learning_flutter/src/database/todo_provider.dart';
import 'package:learning_flutter/src/models/todo_model.dart';
import 'package:learning_flutter/src/themes/light_theme.dart';

class GlobalValues {
  static ValueNotifier updateTodoList = ValueNotifier(false);
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoProvider? todoProvider;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    todoProvider = TodoProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: GlobalValues.updateTodoList,
          builder: (context, value, child) {
            return FutureBuilder(
              future: todoProvider!.fetch(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text(snapshot.error.toString());

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    TodoModel todoTask = snapshot.data![index];

                    return Slidable(
                      key: Key(todoTask.id.toString()),
                      closeOnScroll: true,
                      // mark as complete
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: <Widget>[
                          SlidableAction(
                            onPressed: (context) {
                              todoProvider!
                                  .toggleStatus(todoTask.id, !todoTask.status)
                                  .then((value) {
                                    if (value > 0) {
                                      GlobalValues.updateTodoList.value =
                                          !GlobalValues.updateTodoList.value;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            todoTask.status
                                                ? 'Task completed'
                                                : 'Task uncompleted',
                                          ),
                                        ),
                                      );
                                    }
                                  });
                            },
                            backgroundColor:
                                todoTask.status
                                    ? LightTheme.warning
                                    : LightTheme.success,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            icon:
                                todoTask.status
                                    ? Icons.cancel
                                    : Icons.check_circle,
                            label: todoTask.status ? 'Uncomplete' : 'Complete',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: <Widget>[
                          SlidableAction(
                            onPressed: (context) {
                              _titleController.text = todoTask.title;
                              _descriptionController.text =
                                  todoTask.description;
                              _dateController.text = todoTask.date;
                              _dialogBuilder(context, todoTask.id);
                            },
                            backgroundColor: LightTheme.info,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              todoProvider!.delete(todoTask.id).then((value) {
                                if (value > 0) {
                                  GlobalValues.updateTodoList.value =
                                      !GlobalValues.updateTodoList.value;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Task deleted'),
                                    ),
                                  );
                                }
                              });
                            },
                            backgroundColor: LightTheme.warning,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        isThreeLine: true,
                        leading: Icon(
                          todoTask.status ? Icons.check_circle : Icons.cancel,
                          color:
                              todoTask.status
                                  ? LightTheme.success
                                  : LightTheme.warning,
                        ),
                        title: Text(
                          todoTask.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            decoration:
                                todoTask.status
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(
                          todoTask.description,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Text(todoTask.date),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, [int idTodo = 0]) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: idTodo == 0 ? Text('Add Task') : Text('Edit Task'),
          content: Container(
            height: 280,
            width: 300,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'Titulo de la tarea'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Descripción de la tarea',
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  controller: _dateController,
                  decoration: InputDecoration(hintText: 'Fecha de la tarea'),
                  onTap: () async {
                    DateTime? dateTodo = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (dateTodo != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                        dateTodo,
                      ); // format date in required form here we use yyyy-MM-dd that means time is removed
                      setState(() {
                        _dateController.text =
                            formattedDate; //set foratted date to TextField value.
                      });
                    }
                  },
                ),
                Divider(),
                TextButton(
                  onPressed: () {
                    if (idTodo == 0) {
                      todoProvider!
                          .insert({
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'date': _dateController.text,
                            'status': false,
                          })
                          .then((value) {
                            if (value > 0) {
                              GlobalValues.updateTodoList.value =
                                  !GlobalValues.updateTodoList.value;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Tarea agregada')),
                              );
                            }
                          });
                    } else {
                      todoProvider!
                          .update({
                            'id': idTodo,
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'date': _dateController.text,
                          })
                          .then((value) {
                            if (value > 0) {
                              GlobalValues.updateTodoList.value =
                                  !GlobalValues.updateTodoList.value;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Tarea actualizada'),
                                ),
                              );
                            }
                          });
                    }

                    _titleController.clear();
                    _descriptionController.clear();
                    _dateController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
