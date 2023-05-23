import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tugas_mobile/api/configAPI.dart';
import 'package:tugas_mobile/components/custom_surfix_icon.dart';
import 'package:tugas_mobile/components/default_button_custom_color.dart';
import 'package:tugas_mobile/screens/login/login_screens.dart';
import 'package:tugas_mobile/screens/register/register_screens.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:tugas_mobile/utils/constants.dart';

class SignUpform extends StatefulWidget {
  @override
  _SignUpform createState() => _SignUpform();
}

class _SignUpform extends State<SignUpform> {
  final _formKey = GlobalKey<FormState>;
  String? userName;
  String? password;
  String? email;
  String? nama;
  bool? remember = false;

  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNama = TextEditingController();

  FocusNode focusNode = new FocusNode();

  Response? response;
  var dio = Dio();

  @override
  void initState() {
    // prosesRegistrasi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildNama(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildUserName(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildUserEmail(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildUserPassword(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: 'Register',
            press: () {
              // print(txtEmail.text);
              // print(txtPassword.text);
              // print(txtUserName.text);
              prosesRegistrasi(txtNama.text, txtUserName.text, txtEmail.text,
                  txtPassword.text);
              // prosesRegistrasi(txtNama, txtUserName, txtEmail, txtPassword);
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: Text(
              'Sudah punya akun ? Masuk disini',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildNama() {
    return TextFormField(
      controller: txtNama,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Nama',
          hintText: 'Masukan Nama anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: 'assets/icons/User.svg',
          )),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
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

  TextFormField buildUserEmail() {
    return TextFormField(
      controller: txtEmail,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Masukan email anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: 'assets/icons/Lock.svg',
          )),
    );
  }

  TextFormField buildUserPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Masukan password anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: 'assets/icons/Lock.svg',
          )),
    );
  }

  void prosesRegistrasi(nama, userName, email, password) async {
    bool status;
    var msg;
    try {
      response = await dio.post(urlRegister, data: {
        'nama': nama,
        'username': userName,
        'password': password,
        'email': email,
      });
      status = response?.data['sukses'];
      msg = response?.data['msg'];
      if (status == true) {
        print('sukses');
        Navigator.pushNamed(context, LoginScreen.routeName);
      } else {
        print('gagal');
      }
    } catch (e) {}
    print(response!.data);
  }
}
