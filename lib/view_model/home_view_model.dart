import 'package:sqflite/sqflite.dart';
import 'package:to_do_task/utils/app_utils.dart';
import 'package:to_do_task/view_model/common_view_model.dart';

import '../model/todo_model.dart';
import '../utils/database_helper.dart';

class HomeViewModel extends CommonViewModel {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList = [];
  List<Todo> todoListForSearch = [];
  List<Todo> todoListToday = [];
  List<Todo> todoListTomorrow = [];
  List<Todo> todoListUpcoming = [];


  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        this.todoList = todoList;
        todoListForSearch = this.todoList;
        forTodayList();
        forTomorrowList();
        forUpcomingList();
      });
    });
  }
  forTodayList() {
    todoListToday = todoList
        .where((item) =>
    item.date ==
        AppUtils.instance.convertDateTimeToString(DateTime.now()))
        .toList();
    print("today list ${todoListToday.length}");

  }

  forTomorrowList() {
    todoListTomorrow = todoList

        .where((item) =>
    item.date ==
        AppUtils.instance.convertDateTimeToString(
            DateTime.now().add(const Duration(days: 1))))
        .toList();
    print("today list ${todoListTomorrow.length}");

  }

  forUpcomingList() {
    todoListUpcoming = todoList;
    todoListUpcoming.removeWhere((element) =>
    element.date ==
        AppUtils.instance.convertDateTimeToString(
            DateTime.now().add(const Duration(days: 1))));
    todoListUpcoming.removeWhere((element) =>
    element.date ==
        AppUtils.instance.convertDateTimeToString(DateTime.now()));
    print("today list ${todoListUpcoming.length}");

  }


}
