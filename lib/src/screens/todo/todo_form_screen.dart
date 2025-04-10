import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_flutter/src/database/todo_provider.dart';
import 'package:learning_flutter/src/models/todo_model.dart';
import 'package:learning_flutter/src/utils/global_values.dart';

class TodoFormScreen extends StatefulWidget {
  const TodoFormScreen({super.key});

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  late TodoProvider? todoProvider;
  late TodoModel? todoTask;

  final _taskFormKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    todoProvider = TodoProvider();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initializeForm();
  }

  void _initializeForm() {
    todoTask = ModalRoute.of(context)!.settings.arguments as TodoModel?;

    if (todoTask != null) {
      _titleController.text = todoTask!.title;
      _descriptionController.text = todoTask!.description;
      _dateController.text = todoTask!.date;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  Future<void> _saveTask() async {
    if (!_taskFormKey.currentState!.validate()) return;

    final taskData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
    };

    if (todoTask == null) {
      await _insertTask(taskData);
    } else {
      await _updateTask({'id': todoTask!.id, ...taskData});
    }
  }

  Future<void> _insertTask(Map<String, dynamic> taskData) async {
    final result = await todoProvider!.insert(taskData);

    if (result > 0) {
      GlobalValues.updateTodoList.value = !GlobalValues.updateTodoList.value;

      _showSnackBar('Task added');
    }
  }

  Future<void> _updateTask(Map<String, dynamic> taskData) async {
    final result = await todoProvider!.update(taskData);

    if (result > 0) {
      GlobalValues.updateTodoList.value = !GlobalValues.updateTodoList.value;

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

  Future<void> _selectDate() async {
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
      appBar: AppBar(title: Text(todoTask == null ? 'Add Task' : 'Edit Task')),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _taskFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter title'
                                  : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter description'
                                  : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      decoration: InputDecoration(hintText: 'Select Date'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please select date'
                                  : null,
                      onTap: _selectDate,
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomSheet(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                _saveTask();

                Navigator.pop(context);
              },
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 0,
              height: 50,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Save Task',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
