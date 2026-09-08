import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaModu,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Todo List',
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeMode,
          home: const MyHomePage(title: 'Todo List'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];
  final TextEditingController controller = TextEditingController();

  void addTodo() {
    if (controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todo boş olamaz!'),
          backgroundColor: Colors.teal,
        ),
      );
      return;
    }
    setState(() {
      todos.add(Todo(text: controller.text.trim()));
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
          TextField(
            controller: controller,
            onSubmitted: (_) => addTodo(),
            decoration: InputDecoration(
              hintText: 'Bir todo girin',
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: addTodo,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].text),
                  leading: Checkbox(
                    activeColor: Colors.teal,
                    value: todos[index].isDone,
                    onChanged: (value) {
                      setState(() {
                        todos[index].isDone = !todos[index].isDone;
                      });
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}