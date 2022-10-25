import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/services/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class emailpage extends StatefulWidget {
  const emailpage({super.key});

  @override
  State<emailpage> createState() => _emailpageState();
}

class _emailpageState extends State<emailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Email"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await RajaOngkirServices.sendemail().then((value) {
            var result = json.decode(value.body);
            Fluttertoast.showToast(
                msg: result['message'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor:
                    result['code'] == 200 ? Colors.green : Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        },
        tooltip: 'Send Email',
        child: const Icon(Icons.send_rounded),
      ),
    );
  }
}
