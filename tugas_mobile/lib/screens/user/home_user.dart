import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tugas_mobile/components/login/login_components.dart';
import 'package:tugas_mobile/components/register/register_components.dart';
import 'package:tugas_mobile/screens/admin/crud/detail_product_screen.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:dio/dio.dart';
import '../../api/configAPI.dart';
import '../../utils/constants.dart';
import '../admin/home_admin_screen.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.amber,
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
                color: mTitleColor, fontWeight: FontWeight.bold, fontSize: 13)),
        trailing: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, DetailProductScreen.routeName,
                  arguments: data);
            },
            icon: Icon(Icons.keyboard_arrow_right_outlined)),
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
}
