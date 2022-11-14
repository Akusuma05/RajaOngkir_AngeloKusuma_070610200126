import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/services/services.dart';
import 'package:flutter_application_1/views/pages/verifypage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uni_links/uni_links.dart';

class emailpage extends StatefulWidget {
  const emailpage({super.key});

  @override
  State<emailpage> createState() => _emailpageState();
}

final ctrlEmail = TextEditingController();
final _loginKey = GlobalKey<FormState>();

class _emailpageState extends State<emailpage> {
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  StreamSubscription? _sub;
  final _scaffoldKey = GlobalKey();
  bool udah = false;

  bool _initialUriIsHandled = false;

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        print('got uri: $uri');
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
          udah = true;
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        print('failed to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  @override
  void dispose() {
    ctrlEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (udah == false) {
      _handleInitialUri();
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
    } else {
      return VerifyPage();
    }
  }
}
