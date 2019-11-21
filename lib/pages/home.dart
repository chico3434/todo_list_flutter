import 'package:flutter/material.dart';
import 'package:todo_list_flutter/models/todo.dart';
import 'package:todo_list_flutter/pages/add_todo.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Center(
              child: Text('Todo List'),
            ),
            pinned: true,
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(
                  top: 100,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Total de tarefas: ' + Todo.todoList.length.toString(),
                      style: _textStyle(),
                    ),
                    Text(
                      'Tarefas pendentes: ' + Todo.todoList.length.toString(),
                      style: _textStyle(),
                    ),
                    Text(
                      'Tarefas concluídas: ' + Todo.todoList.length.toString(),
                      style: _textStyle(),
                    ),
                    Text(
                      DateTime.now().toString().substring(0, 16),
                      style: _textStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(_myList()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodoPage()));
        },
        child: Icon(Icons.add),
        heroTag: 'addTag',
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  List<Widget> _myList() {
    List<Widget> list = [];
    if (Todo.todoList.length == 0) {
      list.add(Container(
        margin: EdgeInsets.only(top: 150, left: 75),
        child: Text(
          'Nenhuma tarefa ainda!\nCrie uma tarefa clicando no +',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ));
    }

    for (int i = 0; i < Todo.todoList.length; i++) {
      Todo todo = Todo.todoList[i];
      list.add(ListTile(
        leading: Checkbox(
          value: todo.done,
          onChanged: (value) {
            setState(() {
              Todo.todoList[i].done = value;
            });
          },
        ),
        title: Text(
          todo.title,
        ),
        subtitle: Text(todo.content),
      ));
    }
    return list;
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          color: Colors.blue,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "Todo List",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
