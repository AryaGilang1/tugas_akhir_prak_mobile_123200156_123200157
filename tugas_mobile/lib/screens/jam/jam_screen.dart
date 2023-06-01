import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class JamScreen extends StatefulWidget {
  const JamScreen({Key? key}) : super(key: key);

  @override
  State<JamScreen> createState() => _JamScreenState();
}

class _JamScreenState extends State<JamScreen> {
  DateTime _timeWib = DateTime.now().toUtc().add(Duration(hours: 7));
  DateTime _timeWita = DateTime.now().toUtc().add(Duration(hours: 8));
  DateTime _timeWit = DateTime.now().toUtc().add(Duration(hours: 9));
  DateTime _london = DateTime.now().toUtc().add(Duration(hours: 1));
  String jamLocal = '';
  final DateFormat formatter = DateFormat('EEEE, d MMMM yyyy, HH:mm:ss');

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _timeWib = DateTime.now().toUtc().add(Duration(hours: 7));
          _timeWita = DateTime.now().toUtc().add(Duration(hours: 8));
          _timeWit = DateTime.now().toUtc().add(Duration(hours: 9));
          _london = DateTime.now().toUtc().add(Duration(hours: 1));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              alignment: Alignment.center,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], color: Colors.amber, borderRadius: BorderRadius.circular(40)),
              height: 400,
              width: 250,
              child: Text(
                'WIB : ${formatter.format(_timeWib)}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              padding: EdgeInsets.all(25),
              alignment: Alignment.center,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], color: Colors.amber, borderRadius: BorderRadius.circular(940)),
              height: 400,
              width: 250,
              child: Text(
                'WITA : ${formatter.format(_timeWita)}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              padding: EdgeInsets.all(25),
              alignment: Alignment.center,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], color: Colors.amber, borderRadius: BorderRadius.circular(40)),
              height: 400,
              width: 250,
              child: Text(
                'WIT : ${formatter.format(_timeWit)}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              padding: EdgeInsets.all(25),
              alignment: Alignment.center,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], color: Colors.amber, borderRadius: BorderRadius.circular(40)),
              height: 400,
              width: 250,
              child: Text(
                'London : ${formatter.format(_london)}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
