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
  late TodoProvider? todoProvider;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

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
                TodoModel todoTask = snapshot.data![index];

                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          todoTask.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          todoTask.date,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Builder(
                          builder: (context) {
                            if (todoTask.status) {
                              return const Icon(
                                Icons.check,
                                color: Colors.green,
                              );
                            }

                            return const Icon(Icons.close, color: Colors.red);
                          },
                        ),
                      ),
                      Text(todoTask.description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _titleController.text = todoTask.title;
                              _descriptionController.text =
                                  todoTask.description;
                              _dateController.text = todoTask.date;
                              _statusController.text =
                                  todoTask.status.toString();

                              _dialogBuilder(context, todoTask.id);
                            },
                          ),
                          IconButton(
                            onPressed: () async {
                              await todoProvider!.delete(todoTask.id);

                              setState(() {});
                            },
                            icon: const Icon(Icons.delete),
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
                            'status': false,
                          })
                          .then((value) {
                            if (value > 0) {
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
                            'status': false,
                          })
                          .then((value) {
                            if (value > 0) {
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
