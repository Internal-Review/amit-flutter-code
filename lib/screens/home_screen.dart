// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../resources/localization_text_strings.dart';
// import '../widgets/text_widget.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const TextWidget(text: strMyTask),
//         ),
//         body: Column(
//           children: [
//             TextWidget(text: DateFormat.yMMMMd().format(DateTime.now())),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:to_do_task/screens/to_do_details.dart';
import 'package:to_do_task/utils/app_constant.dart';
import 'package:to_do_task/utils/app_utils.dart';
import 'package:to_do_task/view_model/home_view_model.dart';
import 'package:to_do_task/widgets/common_button.dart';
import 'package:to_do_task/widgets/text_editing_widget.dart';
import 'package:to_do_task/widgets/text_widget.dart';

import '../model/todo_model.dart';
import '../resources/color_resources.dart';
import '../utils/database_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/common_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  DatabaseHelper databaseHelper = DatabaseHelper();

  final TextEditingController _searchController = TextEditingController();
  final List<Widget> _myTabs = const [
    Tab(text: "Today"),
    Tab(text: "Tomorrow"),
    Tab(text: "Up Coming"),
  ];
  List<Todo> todoList = [];
  List<Todo> todoListToday = [];
  List<Todo> todoListTomorrow = [];
  List<Todo> todoListUpcoming = [];
  List<Todo> todoListForSearch = [];
  HomeViewModel? homeViewModel;
TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _myTabs.length);
    _tabController?.addListener(() {
      if(mounted) {
        setState(() {

    });
      }});
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    // TODO: implement initState
    Provider.of<HomeViewModel>(context, listen: false).updateListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeViewModel = Provider.of<HomeViewModel>(context);
    todoList.isEmpty ? homeViewModel!.updateListView() : null;
    todoList = homeViewModel!.todoList;
    todoListUpcoming = homeViewModel!.todoListUpcoming;
    todoListTomorrow = homeViewModel!.todoListTomorrow;
    todoListToday = homeViewModel!.todoListToday;
    todoListForSearch = homeViewModel!.todoListForSearch;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
        ),
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: DefaultTabController(
                  length: _myTabs.length,
                  child: Column(
                    children: [
                      heightBox(14.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: commonTabBar(
                          tabsList: _myTabs,
                        ),
                      ),
                      heightBox(21.h),
                      Expanded(
                        child: TabBarView(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex : 3,
                                          child: TextEditingWidget(
                                            controller: _searchController,
                                            hint: "Search",
                                            onChanged: (val) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                     widthBox(8.w),
                                     Expanded(
                                       flex: 1,
                                       child: CommonButton(
                                         width: 50.w,
                                         onTap: (){
                                           navigateToDetail(
                                               Todo(
                                                   '',
                                                   AppUtils.instance.convertDateTimeToString(DateTime.now()),
                                                   ''),
                                               'Add Todo',
                                               0);
                                         },
                                         text: "Add Task",
                                       ),
                                     )
                                      ],
                                    ),
                                  ),
                                  getTodoListView(
                                      homeViewModel!.todoListToday, 0),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex : 3,
                                          child: TextEditingWidget(
                                            controller: _searchController,
                                            hint: "Search",
                                            onChanged: (val) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        widthBox(8.w),
                                        Expanded(
                                          flex: 1,
                                          child: CommonButton(
                                            width: 50.w,
                                            onTap: (){
                                              navigateToDetail(
                                                  Todo(
                                                      '',
                                                      AppUtils.instance.convertDateTimeToString(DateTime.now().add(Duration(days: 1))),
                                                      ''),
                                                  'Add Todo',
                                                  0);
                                            },
                                            text: "Add Task",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  getTodoListView(
                                      homeViewModel!.todoListTomorrow, 1),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex : 3,
                                          child: TextEditingWidget(
                                            controller: _searchController,
                                            hint: "Search",
                                            onChanged: (val) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        widthBox(8.w),
                                        Expanded(
                                          flex: 1,
                                          child: CommonButton(
                                            width: 50.w,
                                            onTap: (){
                                              navigateToDetail(
                                                  Todo(
                                                      '',
                                                      AppUtils.instance.convertDateTimeToString(DateTime.now().add(Duration(days: 2))),
                                                      ''),
                                                  'Add Todo',
                                                  0);
                                            },
                                            text: "Add Task",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  getTodoListView(
                                      homeViewModel!.todoListUpcoming, 2),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ));
          }),
        ),

      ),
    );
  }

  Widget commonTabBar(
      {TabController? controller, required List<Widget> tabsList}) {
    return TabBar(
      controller: controller,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 2.0,
      isScrollable: false,
      labelColor: colorBlack,
      indicatorColor: colorF03,
      unselectedLabelColor: colorAA3,
      labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      tabs: tabsList,
    );
  }

  ListView getTodoListView(list, index) {
    print("card length ${list.length}");
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int position) {
        Todo cardItem = list[position];
        if (_searchController.text.isNotEmpty &&
            !(cardItem.title.contains(_searchController.text))) {
          return Container();
        } else {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(getFirstLetter(cardItem.title),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              title: Text(cardItem.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(cardItem.description),
              onTap: () {
                debugPrint("ListTile Tapped ${cardItem.id}");
                navigateToDetail(cardItem, 'Edit Todo', index);
              },
            ),
          );
        }
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void navigateToDetail(Todo todo, String title, int index) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ToDoDetail(title, todo, index);
    }));
    print("result $result");
    if (result == true) {
      if (!mounted) return;
      Provider.of<HomeViewModel>(context, listen: false).updateListView();
    }
  }
}
