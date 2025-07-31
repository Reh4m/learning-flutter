import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learning_flutter/src/models/todo_model.dart';
import 'package:learning_flutter/src/config/themes/light_theme.dart';
import 'package:learning_flutter/src/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<TodoProvider>().loadTodos());

    super.initState();
  }

  void _handleUpdateTaskStatus(TodoModel task) async {
    final result = await context.read<TodoProvider>().updateTodoStatus(
      task.id,
      !task.status,
    );

    if (result > 0) {
      _showSnackBar(task.status ? 'Task uncompleted' : 'Task completed');
    }
  }

  void _handleEditTask(TodoModel task) {
    Navigator.pushNamed(context, '/todo-form', arguments: task);
  }

  void _handleDeleteTask(TodoModel task) async {
    final result = await context.read<TodoProvider>().deleteTodo(task.id);

    if (result > 0) {
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
      floatingActionButton: _buildAddTaskButton(),
      body: SafeArea(
        child: Consumer<TodoProvider>(
          builder: (context, provider, child) {
            if (provider.errorMessage.isNotEmpty) {
              return Center(child: Text(provider.errorMessage));
            }

            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return _buildTodoListView(provider.todos);
          },
        ),
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/todo-form'),
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(Icons.add),
    );
  }

  Widget _buildTodoListView(List<TodoModel> todos) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: todos.length,
      itemBuilder: (context, index) => _buildTodoListItem(todos[index]),
    );
  }

  Widget _buildTodoListItem(TodoModel task) {
    return Slidable(
      key: Key(task.id.toString()),
      closeOnScroll: true,
      startActionPane: _buildStartActionPane(task),
      endActionPane: _buildEndActionPane(task),
      child: ListTile(
        isThreeLine: true,
        leading: Icon(
          task.status ? Icons.check_circle : Icons.cancel,
          color: task.status ? LightTheme.success : LightTheme.warning,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            decoration:
                task.status ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(task.description, style: const TextStyle(fontSize: 14)),
        trailing: Text(task.date),
      ),
    );
  }

  ActionPane _buildStartActionPane(TodoModel todoTask) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) => _handleUpdateTaskStatus(todoTask),
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
          onPressed: (context) => _handleEditTask(todoTask),
          backgroundColor: LightTheme.info,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          icon: Icons.edit,
          label: 'Edit',
        ),
        SlidableAction(
          onPressed: (context) => _handleDeleteTask(todoTask),
          backgroundColor: LightTheme.warning,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    );
  }
}
