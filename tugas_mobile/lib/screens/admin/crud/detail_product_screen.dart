import 'package:flutter/material.dart';
import 'package:tugas_mobile/components/admin/crud/detail_screen/detail_gitar_components.dart';
import 'package:tugas_mobile/components/admin/home_admin_components.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:tugas_mobile/utils/constants.dart';

class DetailProductScreen extends StatelessWidget {
  static String routeName = '/detail-gitar';
  static var dataGitar;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataGitar = ModalRoute.of(context)!.settings.arguments as Map;

    print(dataGitar);
    return Scaffold(appBar: AppBar(), body: DetailGitarComponent());
  }
}
