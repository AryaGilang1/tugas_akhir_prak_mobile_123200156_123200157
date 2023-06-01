import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_mobile/components/custom_surfix_icon.dart';
import 'package:tugas_mobile/components/default_button_custom_color.dart';
import 'package:tugas_mobile/screens/admin/crud/detail_product_screen.dart';
import 'package:tugas_mobile/screens/user/home_user_screen.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:tugas_mobile/utils/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tugas_mobile/api/configAPI.dart';
import 'package:image_picker/image_picker.dart';
// import '../../api/configAPI.dart';

class DetailGitar extends StatefulWidget {
  @override
  _DetailGitar createState() => _DetailGitar();
}

class _DetailGitar extends State<DetailGitar> {
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
        child: Center(
      child: Column(
        children: [
          Text(
            '${DetailProductScreen.dataGitar['nama']}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          image == null
              ? Image.network(
                  '$baseUrl/${DetailProductScreen.dataGitar['gambar']}',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  image!,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Harga : ${DetailProductScreen.dataGitar['harga']}'),
              Text('Merk  : ${DetailProductScreen.dataGitar['merk']}'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text('Detail : ${DetailProductScreen.dataGitar['tipe']}'),
        ],
      ),
    ));
  }
}
