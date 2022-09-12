import 'package:to_do_task/model/todo_model.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_task/utils/app_constant.dart';

class DatabaseHelper {

  static DatabaseHelper? _databaseHelper;    // Singleton DatabaseHelper
  static Database? _database;                // Singleton Database



  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    return _databaseHelper ?? DatabaseHelper._createInstance();
  }

  Future<Database> get database async {


    return _database ?? await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}todos.db';

    var todosDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE ${AppConstant.todoTable}(${AppConstant.colId} INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' ${AppConstant.colTitle} TEXT, '
        '${AppConstant.colDescription} TEXT, ${AppConstant.colDate} TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await database;
    var result = await db.query(AppConstant.todoTable, orderBy: '${AppConstant.colTitle} ASC');
    return result;
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await database;
    var result = await db.insert(AppConstant.todoTable, todo.toMap());
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    var db = await database;
    var result = await db.update(AppConstant.todoTable, todo.toMap(), where: '${AppConstant.colId} = ?', whereArgs: [todo.id]);
    return result;
  }


  Future<int> deleteTodo(int id) async {
    var db = await database;
    int result = await db.rawDelete('DELETE FROM ${AppConstant.todoTable} WHERE ${AppConstant.colId} = $id');
    return result;
  }

  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from ${AppConstant.todoTable}');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Todo>> getTodoList() async {

    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;

    List<Todo> todoList =[];
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(Todo.fromMapObject(todoMapList[i]));
    }

    return todoList;
  }

}