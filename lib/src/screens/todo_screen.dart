import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learning_flutter/src/database/todo_provider.dart';
import 'package:learning_flutter/src/models/todo_model.dart';
import 'package:learning_flutter/src/themes/light_theme.dart';
import 'package:learning_flutter/src/utils/global_values.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoProvider? todoProvider;

  @override
  void initState() {
    super.initState();

    todoProvider = TodoProvider();
  }

  void _toggleTaskStatus(TodoModel todoTask) {
    todoProvider!.toggleStatus(todoTask.id, !todoTask.status).then((value) {
      if (value > 0) {
        GlobalValues.updateTodoList.value = !GlobalValues.updateTodoList.value;

        _showSnackBar(todoTask.status ? 'Task completed' : 'Task uncompleted');
      }
    });
  }

  void _editTask(TodoModel todoTask) {
    Navigator.pushNamed(context, '/todo-form', arguments: todoTask);
  }

  void _deleteTask(TodoModel todoTask) {
    todoProvider!.delete(todoTask.id).then((value) {
      if (value > 0) {
        GlobalValues.updateTodoList.value = !GlobalValues.updateTodoList.value;

        _showSnackBar('Task deleted');
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/todo-form'),
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: GlobalValues.updateTodoList,
          builder: (context, value, child) {
            return FutureBuilder<List<TodoModel>>(
              future: todoProvider!.fetch(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

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
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: <Widget>[
                          SlidableAction(
                            onPressed: (context) => _toggleTaskStatus(todoTask),
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
                            onPressed: (context) => _editTask(todoTask),
                            backgroundColor: LightTheme.info,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context) => _deleteTask(todoTask),
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
}
