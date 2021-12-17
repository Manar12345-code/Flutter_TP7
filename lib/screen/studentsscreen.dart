import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:tp7_vf/entities/student.dart';
import 'package:tp7_vf/service/studentservice.dart';
import 'package:tp7_vf/template/navbar.dart';

import '../template/dialog/studentdialog.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar('Etudiant'),
      body: FutureBuilder(
        future: getAllStudent(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                print(index);
                print(snapshot.data[index]);
                return Slidable(
                  key: Key((snapshot.data[index]['id']).toString()),
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddStudentDialog(
                                  notifyParent: refresh,
                                  student: Student(
                                      snapshot.data[index]['dateNais'],
                                      snapshot.data[index]['nom'],
                                      snapshot.data[index]['prenom'],
                                      snapshot.data[index]['id']),
                                );
                              });
                          //print("test");
                        },
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () async {
                      await deleteStudent(snapshot.data[index]['id']);
                      setState(() {
                        snapshot.data.removeAt(index);
                      });
                    }),
                    children: [Container()],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            const Text("Nom et Prénom : "),
                            Text(
                              snapshot.data[index]['nom'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(snapshot.data[index]['prenom']),
                          ],
                        ),
                      ),
                      Text(
                        'Date de Naissance :' +
                            DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                snapshot.data[index]['dateNais'])),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddStudentDialog(
                  notifyParent: refresh,
                );
              });
          //print("test");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
