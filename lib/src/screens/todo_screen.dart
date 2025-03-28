import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_flutter/src/database/todo_provider.dart';
import 'package:learning_flutter/src/models/todo_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoProvider? todoProvider;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

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
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: todoProvider!.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                TodoModel todo = snapshot.data![index];

                return Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 150,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.date),
                        trailing: Builder(
                          builder: (context) {
                            if (todo.status == TodoStatus.done) {
                              return const Icon(
                                Icons.check,
                                color: Colors.green,
                              );
                            }

                            return const Icon(Icons.close, color: Colors.red);
                          },
                        ),
                      ),
                      Text(todo.description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _titleController.text = todo.title;
                              _descriptionController.text = todo.description;
                              _dateController.text = todo.date;
                              _statusController.text = todo.status.toString();

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit Todo'),
                                    content: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: _titleController,
                                          decoration: const InputDecoration(
                                            labelText: 'Title',
                                          ),
                                        ),
                                        TextField(
                                          controller: _descriptionController,
                                          decoration: const InputDecoration(
                                            labelText: 'Description',
                                          ),
                                        ),
                                        TextField(
                                          controller: _dateController,
                                          decoration: const InputDecoration(
                                            labelText: 'Date',
                                          ),
                                        ),
                                        TextField(
                                          controller: _statusController,
                                          decoration: const InputDecoration(
                                            labelText: 'Status',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          TodoModel updatedTodo = TodoModel(
                                            id: todo.id,
                                            title: _titleController.text,
                                            description:
                                                _descriptionController.text,
                                            date: _dateController.text,
                                            status:
                                                _statusController.text == 'done'
                                                    ? TodoStatus.done
                                                    : TodoStatus.notDone,
                                          );

                                          await todoProvider!.update(
                                            updatedTodo as Map<String, dynamic>,
                                          );

                                          setState(() {});

                                          Navigator.pop(context);
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await todoProvider!.delete(todo.id);

                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
                TextFormField(
                  controller: _statusController,
                  decoration: InputDecoration(hintText: 'Estatus de la tarea'),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    if (idTodo == 0) {
                      todoProvider!
                          .insert({
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'date': _dateController.text,
                            'status': TodoStatus.notDone,
                          })
                          .then((value) {
                            if (value > 0) {
                              setState(() {});
                              Navigator.pop(context);
                            }
                          });
                    } else {
                      todoProvider!
                          .update({
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'date': _dateController.text,
                            'status': TodoStatus.notDone,
                          })
                          .then((value) {
                            if (value > 0) {
                              setState(() {});
                              Navigator.pop(context);
                            }
                          });
                    }

                    _titleController.clear();
                    _descriptionController.clear();
                    _dateController.clear();
                    _statusController.clear();
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
