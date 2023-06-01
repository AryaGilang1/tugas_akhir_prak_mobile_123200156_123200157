import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_mobile/routes.dart';
import 'package:tugas_mobile/screens/admin/todo_list.dart';
import 'package:tugas_mobile/screens/login/login_screens.dart';
import 'package:tugas_mobile/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:math';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(
    MaterialApp(
      title: 'Login Page',
      theme: light(),
      initialRoute: LoginScreen.routeName,
      routes: routes,
      // home: CurrencyExchangePage(),
    ),
  );
}
