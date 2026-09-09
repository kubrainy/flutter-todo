import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  final GetStorage _box = GetStorage();
  final int userId;
  TodoController({
    required this.userId
  });
  
  late final String _storageKey = 'todo_$userId';

  var todos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
    ever(todos, (_) => _saveToStorage());
  }

  void _loadFromStorage() {
    final stored = _box.read<List>(_storageKey);
    if (stored != null) {
      todos.assignAll(
        stored.map((e) => Todo.fromJson(Map<String, dynamic>.from(e))),
      );
    }
  }

  void _saveToStorage() {
    _box.write(_storageKey, todos.map((t) => t.toJson()).toList());
  }

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
