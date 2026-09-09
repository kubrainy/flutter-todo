import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../controllers/todo_controller.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final TodoController controller;

  TodoItem({super.key, required this.todo , required this.controller});


  void _showEditDialog(BuildContext context) {
    final editController = TextEditingController(text: todo.text);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Todo Düzenle'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: 'Todo metnini düzenle'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                controller.editTodo(todo.id, editController.text.trim());
                Navigator.of(context).pop();
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        activeColor: Colors.teal,
        value: todo.isDone,
        onChanged: (_) => controller.toggleTodo(todo.id),
      ),
      title: Text(
        todo.text,
        style: TextStyle(
          decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.menu),
        onSelected: (value) {
          if (value == 'delete') {
            controller.deleteTodo(todo.id);
          } else if (value == 'edit') {
            _showEditDialog(context);
          }
        },
        itemBuilder: (context) => [
  const PopupMenuItem(
    value: 'edit',
    child: Row(
      children: [
        Icon(Icons.edit, color: Colors.teal),
        SizedBox(width: 8),
        Text('Düzenle'),
      ],
    ),
  ),
  const PopupMenuItem(
    value: 'delete',
    child: Row(
      children: [
        Icon(Icons.delete, color: Colors.red),
        SizedBox(width: 8),
        Text('Sil'),
      ],
    ),
  ),
],
      ),
    );
  }
}