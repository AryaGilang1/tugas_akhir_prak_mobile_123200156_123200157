import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tugas_mobile/components/login/login_components.dart';
import 'package:tugas_mobile/components/register/register_components.dart';
import 'package:tugas_mobile/size-config.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = '/sign-up';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: RegisterComponent(),
    );
  }
}
