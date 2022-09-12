import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/color_resources.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppConstant {
  static String todoTable = 'todo_table';
  static String colId = 'id';
  static String colTitle = 'title';
  static String colDescription = 'description';
  static String colDate = 'date';


  static Future<void> globalToast(String msg) async {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: colorBlack,
        textColor: colorWhite,
        fontSize:14.sp
    );
  }
}
