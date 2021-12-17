import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../entities/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://192.168.158.97:8081/register";
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future save(user) async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);
    if (res.body != null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 520.0,
                            width: 340.0,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Register",
                                    style: GoogleFonts.oswald(
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                  ),
                                  TextFormField(
                                    controller: emailCtrl,
                                    decoration: const InputDecoration(
                                        labelText: "Email"),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: passwordCtrl,
                                    decoration: const InputDecoration(
                                        labelText: "Password"),
                                    obscureText: true,
                                  ),
                                  const SizedBox(
                                    height: 60.0,
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle:
                                            const TextStyle(fontSize: 10),
                                        backgroundColor: const Color.fromRGBO(
                                            237, 9, 144, 1.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          save(User(emailCtrl.text,
                                              passwordCtrl.text));
                                        }
                                      },
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ])))));
  }
}
