import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_input.dart';
import '../widgets/todo_item.dart';
import '../utils/theme.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({super.key, required this.user});

  final User user;
  late final TodoController controller = Get.put(TodoController(userId: user.id), tag:'${user.id}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(user.name),
        centerTitle: true,
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: temaModu,
            builder: (context, currentMode, child) {
              return IconButton(
                icon: Icon(
                  currentMode == ThemeMode.dark
                      ? Icons.nightlight_round
                      : Icons.sunny,
                ),
                color: Colors.teal,
                onPressed: toggleTheme,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Text(' My Todo List'),
          TodoInput(controller: controller),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  return TodoItem(todo: controller.todos[index] , controller: controller);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}