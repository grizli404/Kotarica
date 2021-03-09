import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/api.services.dart';
import 'package:flutter_application_1/models/student.dart';

class Students extends StatefulWidget {
  Students({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _StudentState();
}

class _StudentState extends State<Students> {
  List<Student> students;

  getStudent() {
    APIServices.fetchStudent().then((response) {
      Iterable list = json.decode(response.body);
      List<Student> studentList = List<Student>();
      studentList = list.map((model) => Student.fromObject(model)).toList();

      setState(() {
        students = studentList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getStudent();
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: students == null
          ? Center(child: Text('empty'))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    title: Text(students[index].imePrezime),
                    onTap: null,
                  ),
                );
              },
            ),
    );
  }
}
