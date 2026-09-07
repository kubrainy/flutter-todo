import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(title: 'Demo Todo List'),
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
  List<Todo> todos=[];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('Todo List'),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Bir todo girin',
              icon: Icon(Icons.add),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(todos[index].text),
                  leading: Checkbox(
                    value: todos[index].isDone,
                    onChanged:(value){
                      setState(() {
                      todos[index].isDone = !todos[index].isDone;
                      });
                    }
                  )
                );
              }
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState((){
            todos.add(Todo(text: controller.text));
            controller.clear();
          });
          print('Todo eklendi.');
        },
        child: const Icon(Icons.add)
      )
    );
  }
}
