import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_task/utils/app_constant.dart';
import 'package:to_do_task/view_model/common_view_model.dart';

import '../screens/home_screen.dart';
import '../utils/database_helper.dart';

class TaskDetailViewModel extends CommonViewModel {
  DatabaseHelper databaseHelper = DatabaseHelper();

  saveTask(context, todo) async {
    // todo.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (todo.id != null) {
      // Update operation
      result = await databaseHelper.updateTodo(todo);
    } else {
      // Insert Operation
      result = await databaseHelper.insertTodo(todo);
    }

    if (result != 0) {
      AppConstant.globalToast('Todo Saved Successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      AppConstant.globalToast('Problem Saving Todo');
    }
  }

  deleteTask(context, todo) async {
    if (todo.id == null) {
      AppConstant.globalToast('No Todo was deleted');
      return;
    }

    int? result =
        todo.id != null ? await databaseHelper.deleteTodo(todo.id!) : null;
    if (result != 0) {
      AppConstant.globalToast('Todo Deleted Successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      AppConstant.globalToast('Error Occurred while Deleting Todo');
    }
    notifyListeners();
  }
}
