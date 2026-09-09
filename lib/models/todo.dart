class Todo {
  final String id;
  String text;
  bool isDone;

  Todo({
    required this.id,
    required this.text,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'isDone': isDone,
      };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'] as String,
        text: json['text'] as String,
        isDone: json['isDone'] as bool? ?? false,
      );
}
