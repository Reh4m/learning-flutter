import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_flutter/src/models/todo_model.dart';
import 'package:learning_flutter/src/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoFormScreen extends StatefulWidget {
  const TodoFormScreen({super.key});

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  late TodoModel? _editingTask;

  final _taskFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initializeFormFields();
  }

  void _initializeFormFields() {
    _editingTask = ModalRoute.of(context)!.settings.arguments as TodoModel?;

    if (_editingTask != null) {
      _titleController.text = _editingTask!.title;
      _descriptionController.text = _editingTask!.description;
      _dateController.text = _editingTask!.date;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  Future<void> _handleSaveTask() async {
    if (!_taskFormKey.currentState!.validate()) return;

    final taskData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
    };

    if (_editingTask == null) {
      await _addNewTask(taskData);
    } else {
      await _updateExistingTask({'id': _editingTask!.id, ...taskData});
    }

    if (mounted) Navigator.pop(context);
  }

  Future<void> _addNewTask(Map<String, dynamic> taskData) async {
    final result = await context.read<TodoProvider>().addTodo(taskData);

    if (result > 0) {
      _showSnackBar('Task added');
    } else {
      _showSnackBar('Failed to add task');
    }
  }

  Future<void> _updateExistingTask(Map<String, dynamic> taskData) async {
    final result = await context.read<TodoProvider>().updateTodo(taskData);

    if (result > 0) {
      _showSnackBar('Task updated');
    } else {
      _showSnackBar('Failed to update task');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editingTask == null ? 'Add Task' : 'Edit Task'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildTaskForm(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildSaveButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskForm() {
    return Form(
      key: _taskFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter title'
                        : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter description'
                        : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            readOnly: true,
            controller: _dateController,
            decoration: const InputDecoration(hintText: 'Select Date'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please select date'
                        : null,
            onTap: _pickDate,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return FilledButton(
      onPressed: _handleSaveTask,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size(double.infinity, 0),
      ),
      child: const Text(
        'Save Task',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
