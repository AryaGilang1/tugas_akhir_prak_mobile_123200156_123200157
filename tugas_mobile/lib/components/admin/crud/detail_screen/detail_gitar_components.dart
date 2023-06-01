import 'package:flutter/material.dart';
import 'package:tugas_mobile/components/admin/crud/detail_screen/detail_gitar_form.dart';
import 'package:tugas_mobile/components/admin/crud/input_gitar/input_gitar_form.dart';
import 'package:tugas_mobile/components/login/login_form.dart';
import 'package:tugas_mobile/size-config.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:tugas_mobile/utils/constants.dart';

class DetailGitarComponent extends StatefulWidget {
  @override
  _DetailGitarComponent createState() => _DetailGitarComponent();
}

class _DetailGitarComponent extends State<DetailGitarComponent> {
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
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail data gitar',
                        style: mTitleStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DetailGitar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
