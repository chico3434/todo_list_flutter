class Todo {
  String title;
  String content;
  DateTime date;
  bool done = false;

  Todo({this.title, this.content, this.date});

  static List<Todo> todoList = [];

  static void addTodo(Todo todo) {
    todoList.add(todo);
  }
}