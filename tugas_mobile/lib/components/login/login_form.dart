import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tugas_mobile/components/admin/home_admin_components.dart';
import 'package:tugas_mobile/components/custom_surfix_icon.dart';
import 'package:tugas_mobile/components/default_button_custom_color.dart';
import 'package:tugas_mobile/screens/admin/home_admin_screen.dart';
import 'package:tugas_mobile/screens/register/register_screens.dart';
import 'package:tugas_mobile/screens/user/home_user_screen.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:tugas_mobile/utils/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/configAPI.dart';

class SignInform extends StatefulWidget {
  @override
  _SignInform createState() => _SignInform();
}

class _SignInform extends State<SignInform> {
  final _formKey = GlobalKey<FormState>;
  String? username;
  String? password;
  bool remember = false;
  bool sandi = false;

  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  FocusNode focusNode = new FocusNode();

  Response? response;
  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return //FutureBuilder(
        // future: getPreference(),
        //builder: (context, _) =>
        Form(
      child: Column(
        children: [
          buildUserName(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildUserPassword(),
          SizedBox(
            height: 20,
          ),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: 'Login',
            press: () {
              prosesRegistrasi(txtUserName.text, txtPassword.text);
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
            child: Text(
              'Belum punya akun? Buat disini',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          labelText: 'Username',
          hintText: 'Masukan Username anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: 'assets/icons/User.svg',
          )),
    );
  }

  TextFormField buildUserPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: sandi,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Masukan password anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (sandi == true) {
                  sandi = false;
                } else {
                  sandi = true;
                }
              });
            },
            icon: sandi ? Icon(Icons.lock) : Icon(Icons.key_outlined),
          )),
    );
  }

  void prosesRegistrasi(userName, password) async {
    bool status;
    var msg;
    var dataUSer;
    try {
      response = await dio.post(urlLogin, data: {
        'username': userName,
        'password': password,
      });
      status = response?.data['sukses'];
      msg = response?.data['msg'];
      if (status == true) {
        print('sukses');
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Login Sukses',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            dataUSer = response!.data['data'];
            if (dataUSer['role'] == 1) {
              print('lempar ke halaman user');
              Navigator.pushNamed(context, HomeUserScreen.routeName);
            } else if (dataUSer['role'] == 2) {
              Navigator.pushNamed(context, HomeAdminScreen.routeName);
              print('lempar ke halaman admin');
            }
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: '$msg',
          btnOkOnPress: () {},
        ).show();
        print('gagal');
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: '$msg',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
    print(response!.data);
  }
}
