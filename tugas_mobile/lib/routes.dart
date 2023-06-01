import 'package:flutter/material.dart';
import 'package:tugas_mobile/components/admin/home_admin_components.dart';
import 'package:tugas_mobile/screens/admin/crud/detail_product_screen.dart';
import 'package:tugas_mobile/screens/admin/crud/input_gitar_screen.dart';
import 'package:tugas_mobile/screens/admin/home_admin_screen.dart';
import 'package:tugas_mobile/screens/admin/todo_list.dart';
import 'package:tugas_mobile/screens/login/login_screens.dart';
import 'package:tugas_mobile/screens/register/register_screens.dart';
import 'package:tugas_mobile/screens/user/home_user_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  HomeUserScreen.routeName: (context) => HomeUserScreen(),
  HomeAdminScreen.routeName: (context) => HomeAdminScreen(),
  InputGitarScreen.routeName: (context) => InputGitarScreen(),
  TodoList.routeName: (context) => TodoList(),
  DetailProductScreen.routeName: (context) => DetailProductScreen(),
};
