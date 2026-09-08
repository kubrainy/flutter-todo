import 'package:get/get.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void addTodo(String text) {
    todos.add(Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
    ));
  }

  void toggleTodo(String id) {
    final todo = todos.firstWhere((t) => t.id == id);
    todo.isDone = !todo.isDone;
    todos.refresh();
  }

  void deleteTodo(String id) {
    todos.removeWhere((t) => t.id == id);
  }

  void editTodo(String id, String newText) {
    final todo = todos.firstWhere((t) => t.id == id);
    todo.text = newText;
    todos.refresh();
  }
}