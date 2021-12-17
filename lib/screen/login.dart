import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../entities/user.dart';
import 'dashboard.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://192.168.158.97:8081/login";
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future save(user) async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);
    if (res.body != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
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
                                  Text("Login",
                                      style: GoogleFonts.oswald(
                                          fontSize: 40, color: Colors.black)),
                                  const Align(
                                    alignment: Alignment.center,
                                  ),
                                  TextFormField(
                                    controller: emailCtrl,
                                    decoration:
                                        InputDecoration(labelText: "Email"),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: passwordCtrl,
                                    decoration:
                                        InputDecoration(labelText: "Password"),
                                    obscureText: true,
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register()));
                                      },
                                      child: Text(
                                        "Dont have Account ?",
                                        style: TextStyle(
                                            color: Colors.pinkAccent,
                                            fontSize: 20),
                                      ),
                                    ),
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
                                            255, 0, 128, 1.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])))));
  }
}
