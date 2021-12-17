import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp7_vf/template/navbar.dart';

class Dashboard extends StatefulWidget {
  //const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedClass;
  String selectedStud;
  List data = List();
  List etud = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar('Dashboard'),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 100,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    'Gestion des Etudiants',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Etudiants'),
                tileColor: Colors.pinkAccent,
                onTap: () {
                  Navigator.pushNamed(context, '/students');
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ListTile(
                title: const Text('Classes'),
                tileColor: Colors.pinkAccent,
                onTap: () {
                  Navigator.pushNamed(context, '/class');
                },
              ),
            ],
          ),
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  focusColor: Colors.pinkAccent,
                  value: selectedClass,
                  hint: Text("Select Class"),
                  items: data.map(
                    (list) {
                      return DropdownMenuItem(
                        child: Text(list['nomClass']),
                        value: list['nomClass'],
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedClass = value;
                    });
                  },
                ),
              ),
            ])));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllClasses();
  }

  Future getAllClasses() async {
    String url = "http://192.168.158.97:8081/classes";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.data = json.decode(resp.body)['_embedded']['classes'];
      });
    }).catchError((err) {
      print(err);
    });
  }

  /* Future getStudents(int id) async {
    String url = "http://192.168.158.102:8081/classes/$id/etudiants";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.etud = json.decode(resp.body)['_embedded']['etudiants'];
      });
    }).catchError((err) {
      print(err);
    });
  }*/
}
