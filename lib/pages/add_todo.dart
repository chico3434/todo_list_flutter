import 'package:flutter/material.dart';
import 'package:todo_list_flutter/models/todo.dart';

class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey();

  String _title;
  String _content;
  DateTime _dateTime;
  TimeOfDay _timeOfDay;
  DateTime _date;

  void _datePicker(context) {
    Future<DateTime> future = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    future.then((value) {
      setState(() {
        _dateTime = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timeOfDay = TimeOfDay.now();
  }

  void _timePicker(context) {
    Future<TimeOfDay> future = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    future.then((value) {
      setState(() {
        _timeOfDay = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) => _title = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Digite um título';
                  }
                  return '';
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              TextFormField(
                onChanged: (value) => _content = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Digite o conteúdo';
                  }
                  return '';
                },
                decoration: InputDecoration(
                  labelText: 'Content',
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(4),
                title: Text(
                  '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                ),
                subtitle: Text(
                  'Change Date',
                  style: TextStyle(color: Colors.blue),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.blue,
                  size: 30,
                ),
                onTap: () => _datePicker(context),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(4),
                title: Text(
                  '${_timeOfDay.hour}:${_timeOfDay.minute}',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.timer,
                  color: Colors.blue,
                ),
                subtitle: Text(
                  'Change Time',
                  style: TextStyle(color: Colors.blue),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.blue,
                  size: 30,
                ),
                onTap: () => _timePicker(context),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton.icon(
                  icon: Hero(child: Icon(Icons.add), tag: 'addTag'),
                  label: Text('Add'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _date = DateTime(_dateTime.year, _dateTime.month,
                        _dateTime.day, _timeOfDay.hour, _timeOfDay.minute);
                    Todo todo =
                        Todo(title: _title, content: _content, date: _date);
                    Todo.addTodo(todo);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
