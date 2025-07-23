import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learning_flutter/src/database/todo_provider.dart';
import 'package:learning_flutter/src/models/todo_model.dart';
import 'package:learning_flutter/src/config/themes/light_theme.dart';
import 'package:learning_flutter/src/utils/global_values.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoProvider todoProvider;

  @override
  void initState() {
    super.initState();

    todoProvider = TodoProvider();
  }

  void _toggleTaskStatus(TodoModel todoTask) async {
    final result = await todoProvider.toggleStatus(
      todoTask.id,
      !todoTask.status,
    );

    if (result > 0) {
      GlobalValues.updateTodoList.value = !GlobalValues.updateTodoList.value;

      _showSnackBar(todoTask.status ? 'Task uncompleted' : 'Task completed');
    }
  }

  void _editTask(TodoModel todoTask) {
    Navigator.pushNamed(context, '/todo-form', arguments: todoTask);
  }

  void _deleteTask(TodoModel todoTask) async {
    final result = await todoProvider.delete(todoTask.id);

    if (result > 0) {
      GlobalValues.updateTodoList.value = !GlobalValues.updateTodoList.value;

      _showSnackBar('Task deleted');
    }
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
      floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: GlobalValues.updateTodoList,
          builder: (context, value, child) {
            return FutureBuilder<List<TodoModel>>(
              future: todoProvider.fetch(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return _buildTodoList(snapshot.data!);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/todo-form'),
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(Icons.add),
    );
  }

  Widget _buildTodoList(List<TodoModel> todoList) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        final todoTask = todoList[index];

        return _buildTodoItem(todoTask);
      },
    );
  }

  Widget _buildTodoItem(TodoModel todoTask) {
    return Slidable(
      key: Key(todoTask.id.toString()),
      closeOnScroll: true,
      startActionPane: _buildStartActionPane(todoTask),
      endActionPane: _buildEndActionPane(todoTask),
      child: ListTile(
        isThreeLine: true,
        leading: Icon(
          todoTask.status ? Icons.check_circle : Icons.cancel,
          color: todoTask.status ? LightTheme.success : LightTheme.warning,
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
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        trailing: Text(todoTask.date),
      ),
    );
  }

  ActionPane _buildStartActionPane(TodoModel todoTask) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) => _toggleTaskStatus(todoTask),
          backgroundColor:
              todoTask.status ? LightTheme.warning : LightTheme.success,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          icon: todoTask.status ? Icons.cancel : Icons.check_circle,
          label: todoTask.status ? 'Uncomplete' : 'Complete',
        ),
      ],
    );
  }

  ActionPane _buildEndActionPane(TodoModel todoTask) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) => _editTask(todoTask),
          backgroundColor: LightTheme.info,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          icon: Icons.edit,
          label: 'Edit',
        ),
        SlidableAction(
          onPressed: (context) => _deleteTask(todoTask),
          backgroundColor: LightTheme.warning,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    );
  }
}
