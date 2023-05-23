import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_mobile/components/custom_surfix_icon.dart';
import 'package:tugas_mobile/components/default_button_custom_color.dart';
import 'package:tugas_mobile/screens/admin/home_admin_screen.dart';
import 'package:tugas_mobile/screens/register/register_screens.dart';
import 'package:tugas_mobile/screens/user/home_user_screen.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:tugas_mobile/utils/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tugas_mobile/api/configAPI.dart';
import 'package:image_picker/image_picker.dart';
// import '../../api/configAPI.dart';

class FormInputGitar extends StatefulWidget {
  @override
  _FormInputGitar createState() => _FormInputGitar();
}

class _FormInputGitar extends State<FormInputGitar> {
  TextEditingController txtNamaGitar = TextEditingController();
  TextEditingController txtTipeGitar = TextEditingController();
  TextEditingController txtHargaGitar = TextEditingController();
  TextEditingController txtMerkGitar = TextEditingController();
  FocusNode focusNode = new FocusNode();
  File? image;

  Response? response;
  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildNamaGitar(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildTipeGitar(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildHargaGitar(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildMerkGitar(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DefaultButtonCustomeColor(
            color: kColorRedSlow,
            text: 'Pilih Gambar Gitar',
            press: () {
              pilihGambar();
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          image == null
              ? Container()
              : Image.file(
                  image!,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: 'Input Data',
            press: () {
              inputDataGitar(txtNamaGitar.text, txtTipeGitar.text,
                  txtHargaGitar.text, txtMerkGitar.text, image?.path);
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextFormField buildNamaGitar() {
    return TextFormField(
      controller: txtNamaGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Nama Gitar',
          hintText: 'Masukan Nama Gitar',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person)),
    );
  }

  TextFormField buildTipeGitar() {
    return TextFormField(
      controller: txtTipeGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Tipe Gitar',
          hintText: 'Masukan Tipe Gitar',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.electric_bolt_rounded)),
    );
  }

  TextFormField buildHargaGitar() {
    return TextFormField(
      controller: txtHargaGitar,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Harga Gitar',
          hintText: 'Masukan Harga Gitar',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.attach_money_outlined)),
    );
  }

  TextFormField buildMerkGitar() {
    return TextFormField(
      controller: txtMerkGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Merk Gitar',
          hintText: 'Masukan Merk Gitar',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.headphones_battery_rounded)),
    );
  }

  Future pilihGambar() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('gagal mengambil foto : $e');
    }
  }

  void inputDataGitar(nama, tipe, harga, merk, gambar) async {
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'nama': nama,
        'tipe': tipe,
        'harga': harga,
        'merk': merk,
        'gambar': await MultipartFile.fromFile(gambar)
      });

      response = await dio.post(inputGitar, data: formData);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status == true) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Sukses',
          desc: '$msg',
          btnOkOnPress: () {
            Navigator.pushNamed(context, HomeAdminScreen.routeName);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Gagal',
          desc: 'terjadi kesalahan',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {}
  }
}
