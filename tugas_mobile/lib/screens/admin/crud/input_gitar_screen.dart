import 'package:flutter/material.dart';
import 'package:tugas_mobile/components/admin/crud/input_gitar/input_gitar_components.dart';

class InputGitarScreen extends StatelessWidget {
  static String routeName = '/input-gitar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InputGitarComponents(),
    );
  }
}
