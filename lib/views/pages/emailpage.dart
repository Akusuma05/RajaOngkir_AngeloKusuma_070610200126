import 'dart:convert';

import 'package:email_validator/email_validator.dart';
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

final ctrlEmail = TextEditingController();
final _loginKey = GlobalKey<FormState>();

class _emailpageState extends State<emailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Email"),
      ),
      body: Center(
        child: Form(
          key: _loginKey,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email_outlined),
              hintText: "Email",
            ),
            controller: ctrlEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return !EmailValidator.validate(value.toString())
                  ? 'Email tidak valid'
                  : null;
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_loginKey.currentState!.validate()) {
            await RajaOngkirServices.sendemail(ctrlEmail.text.toString())
                .then((value) {
              var result = json.decode(value.body);

              Fluttertoast.showToast(
                msg: "Berhasil",
                toastLength: Toast.LENGTH_SHORT,
              );
            });
          } else {
            Fluttertoast.showToast(
              msg: "Gagal",
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        },
        tooltip: 'Send Email',
        child: const Icon(Icons.send_rounded),
      ),
    );
  }
}
