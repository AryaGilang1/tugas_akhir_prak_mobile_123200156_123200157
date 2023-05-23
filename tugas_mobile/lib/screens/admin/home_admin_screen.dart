import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_mobile/api/configAPI.dart';
import 'package:tugas_mobile/components/admin/home_admin_components.dart';
import 'package:tugas_mobile/screens/admin/crud/input_gitar_screen.dart';
import 'package:tugas_mobile/screens/admin/todo_list.dart';
import 'package:tugas_mobile/screens/login/login_screens.dart';
import 'package:tugas_mobile/screens/profile/profile_screen.dart';
import 'package:tugas_mobile/utils/color_manager.dart';

class HomeAdminScreen extends StatefulWidget {
  static var routeName = '/home-admin';

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  late SharedPreferences prefData;
  bool remember = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    prefData = await SharedPreferences.getInstance();
  }

  Future<void> setPreference() async {
    final ingat = await SharedPreferences.getInstance();

    if (ingat.containsKey('myData')) {
      ingat.clear();
    }

    final myData = json.encode({'remember': remember.toString()});

    ingat.setString('myData', myData);
    setState(() {});
  }

  Future<void> getPreference() async {
    final ingat = await SharedPreferences.getInstance();

    var myDataString = ingat.getString('myData');
    if (myDataString != null) {
      final myData = json.decode(myDataString) as Map<String, dynamic>;

      remember = myData['remember'] == "true" ? true : false;
    }
  }

  void rememberMe() {
    remember = !remember;
    setPreference();
  }

  @override
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeAdminComponents(),
    TodoList(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPreference(),
        builder: (context, snapshot) => Scaffold(
              backgroundColor: remember ? Colors.white : Colors.indigo,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor:
                    remember ? ColorManager.black : ColorManager.pink,
                elevation: 0,
                title: Text(''),
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: rememberMe,
                  icon: Icon(
                    Icons.color_lens,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, InputGitarScreen.routeName);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          'Input Data',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                },
                child: Icon(Icons.login_rounded),
                backgroundColor: Colors.blue,
              ),
              body: Column(
                children: [_widgetOptions.elementAt(_selectedIndex)],
              ),
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor:
                    remember ? ColorManager.grey60 : ColorManager.pink,
                // height: 50,
                items: [
                  Icon(Icons.add, size: 20),
                  Icon(Icons.list, size: 20),
                  Icon(Icons.person, size: 20),
                ],
                onTap: (index) {
                  setState(() {
                    _onItemTapped(index);
                  });
                },
              ),
            ));
  }
}
