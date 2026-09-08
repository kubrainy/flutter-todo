class Todo {
  final String id;
  String text;
  bool isDone;  

  Todo({
    required this.id,
    required this.text,
    this.isDone = false,
  });
}


