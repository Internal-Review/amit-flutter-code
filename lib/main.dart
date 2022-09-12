import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_task/screens/home_screen.dart';
import 'package:to_do_task/utils/app_constant.dart';
import 'package:to_do_task/view_model/common_view_model.dart';
import 'package:to_do_task/view_model/home_view_model.dart';
import 'package:to_do_task/view_model/task_detail_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => CommonViewModel()),
                ChangeNotifierProvider(create: (_) => HomeViewModel()),
                ChangeNotifierProvider(create: (_) => TaskDetailViewModel()),
              ],
              child: MaterialApp(
                navigatorKey: rootNavigatorKey,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const HomeScreen(),
              ),
            ));
  }
}
