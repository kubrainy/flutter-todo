import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class TodoInput extends StatefulWidget {
  const TodoInput({super.key});

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final _textController = TextEditingController();
  final TodoController controller = Get.find<TodoController>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todo boş olamaz!'),
          backgroundColor: Colors.teal,
        ),
      );
      return;
    }
    controller.addTodo(_textController.text.trim());
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onSubmitted: (_) => _submit(),
      decoration: InputDecoration(
        hintText: 'Bir todo girin',
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: _submit,
        ),
      ),
    );
  }
}