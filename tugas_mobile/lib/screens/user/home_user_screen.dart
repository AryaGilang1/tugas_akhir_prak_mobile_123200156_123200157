import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tugas_mobile/components/login/login_components.dart';
import 'package:tugas_mobile/components/register/register_components.dart';
import 'package:tugas_mobile/screens/admin/crud/detail_product_screen.dart';
import 'package:tugas_mobile/screens/api/screens/chuck_noris.dart';
import 'package:tugas_mobile/screens/jam/jam_screen.dart';
import 'package:tugas_mobile/screens/login/login_screens.dart';
import 'package:tugas_mobile/screens/profile/profile_screen.dart';
import 'package:tugas_mobile/screens/user/home_user.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:dio/dio.dart';
import '../../api/configAPI.dart';
import '../../utils/constants.dart';
import '../admin/home_admin_screen.dart';
import '../exchange/currency_dropdown.dart';

class HomeUserScreen extends StatefulWidget {
  static String routeName = '/home-screen';

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeUser(),
    CurrencyExchangePage(),
    JamScreen(),
    // ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
            },
            icon: Icon(Icons.person)),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChuckNorrisJokePage(),
                    ));
              },
              child: Text(
                'Bored?',
                style: TextStyle(color: Colors.black),
              ))
        ],
        title: Text('Gitar Rock & Roll'),
      ),
      body: Column(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // fixedColor: Colors.red,
        // unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shop,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_rounded), label: 'currency'),
          BottomNavigationBarItem(icon: Icon(Icons.lock_clock), label: 'waktu'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.routeName, (route) => false);
          },
          child: Icon(Icons.logout)),
    );
  }
}
