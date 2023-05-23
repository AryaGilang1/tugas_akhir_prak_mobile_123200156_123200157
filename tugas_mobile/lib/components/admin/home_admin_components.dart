import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tugas_mobile/api/configAPI.dart';
import 'package:tugas_mobile/components/admin/crud/input_gitar/input_gitar_form.dart';
import 'package:tugas_mobile/components/login/login_form.dart';
import 'package:tugas_mobile/screens/admin/home_admin_screen.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:tugas_mobile/utils/constants.dart';

class HomeAdminComponents extends StatefulWidget {
  @override
  _HomeAdminComponents createState() => _HomeAdminComponents();
}

class _HomeAdminComponents extends State<HomeAdminComponents> {
  Response? response;
  var dio = Dio();
  var dataGitar;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataGitar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return cardDataGitar(dataGitar[index]);
                    },
                    itemCount: dataGitar == null ? 0 : dataGitar.length,
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardDataGitar(data) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Container(
              padding: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Image.network('$baseUrl/${data['gambar']}'),
            ),
            title: Text('${data['nama']}',
                style: TextStyle(
                    color: mTitleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.keyboard_arrow_right_outlined)),
            subtitle: GestureDetector(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'peringatan',
                  desc: 'yakin hapus ${data['nama']}?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    deleteGitar('${data['_id']}');
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeAdminScreen.routeName, (route) => false);
                  },
                ).show();
              },
              child: Text('delete'),
            )),
      ),
    );
  }

  void getDataGitar() async {
    bool status;
    var msg;
    try {
      response = await dio.get(getAllGitar);

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status == true) {
        setState(() {
          dataGitar = response!.data['data'];
        });
        // print(dataGitar);
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteGitar(id) async {
    bool status;
    var msg;
    try {
      response = await dio.delete('$hapusGitar/$id');

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status == true) {
        // print(dataGitar);
      }
    } catch (e) {
      print(e);
    }
  }
}
