import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_task/resources/color_resources.dart';
import 'package:to_do_task/resources/localization_text_strings.dart';
import 'package:to_do_task/view_model/task_detail_view_model.dart';
import 'package:to_do_task/widgets/common_widget.dart';
import 'package:to_do_task/widgets/text_editing_widget.dart';

import '../model/todo_model.dart';
import '../utils/app_constant.dart';
import '../utils/app_utils.dart';
import '../utils/database_helper.dart';
import '../widgets/common_button.dart';
import 'home_screen.dart';

class ToDoDetail extends StatefulWidget {
  final String appBarTitle;
  final Todo todo;
  final int currentIndex;

  const ToDoDetail(this.appBarTitle, this.todo, this.currentIndex, {Key? key})
      : super(key: key);

  @override
  State<ToDoDetail> createState() {
    return _ToDoDetailState();
  }
}

class _ToDoDetailState extends State<ToDoDetail> {
  String appBarTitle = "";
  Todo? todo ;

  _ToDoDetailState();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    appBarTitle = widget.appBarTitle;
    todo = widget.todo;
    titleController.text = todo!.title;
    descriptionController.text = todo!.description;
    dateController.text = todo!.date;
    print("Current index ${widget.currentIndex}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TaskDetailViewModel taskDetailViewModel =
        Provider.of<TaskDetailViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        moveToLastScreen();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Write some code to control things, when user press back button in AppBar
                moveToLastScreen();
              }),
        ),
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ListView(
                children: <Widget>[
                  heightBox(15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: TextEditingWidget(
                        controller: titleController,
                        onChanged: (value) {
                          updateTitle();
                        },
                        labelText: strTitle),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: TextEditingWidget(
                        controller: descriptionController,
                        onChanged: (value) {
                          updateDescription();
                        },
                        labelText: strDescription),
                  ),
                  heightBox(10.h),
                TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        String formattedDate = AppUtils.instance
                            .convertDateTimeToString(pickedDate);
                        setState(() {
                          todo!.date = formattedDate;
                          dateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ) ,
                  heightBox(30.h),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          onTap: () {
                            if (titleController.text.isNotEmpty) {

                              taskDetailViewModel.saveTask(context, todo);
                            } else {
                              AppConstant.globalToast("Please Enter $strTitle");
                            }
                          },
                          backgroundColor: color080,
                          textColor: colorWhite,
                          horizontalOutMargin: 10.w,
                          text: strSaveTask,
                          width: constraints.maxWidth,
                        ),
                      ),
                      todo!.id != null
                          ? Expanded(
                              child: CommonButton(
                                onTap: () {
                                  print(todo!.id);
                                  taskDetailViewModel.deleteTask(context, todo);
                                },
                                horizontalOutMargin: 10.w,
                                text: strDeleteTask,
                                width: constraints.maxWidth,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          );
        })),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
  );
  }

  void updateTitle() {
    todo!.title = titleController.text;
  }

  void updateDescription() {
    todo!.description = descriptionController.text;
  }
}
