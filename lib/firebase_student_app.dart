import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseStudentApp extends StatelessWidget {
  const FirebaseStudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StudentList(),
    );
  }
}

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => StudentListState();
}

class StudentListState extends State<StudentList> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference studentCollectionRef = firebaseFirestore.collection('students');
  List<Student> studentList = [];


  Future <void> getStudentData()  async {
     studentList.clear();
     final QuerySnapshot result =
     await studentCollectionRef.get();
     print(result.size);
     for (QueryDocumentSnapshot element in result.docs) {
       print(element.data());
       print(element.get('name'));
       Student student = Student(element.get('name'), int.tryParse( element.get('roll').toString())?? 0);
       studentList.add(student);
     }
     if (mounted) {
       setState(() {});
     }

  }

  @override
  void initState() {
    super.initState();
    getStudentData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('student list'),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await getStudentData();
        },


        child: ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (context, index) {

            return  ListTile(
              leading: CircleAvatar(
                child: Text(studentList[index].roll.toString()),
              ),
              title: Text(studentList[index].name),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          studentCollectionRef.add({
            'name' : 'Abrar',
            'roll' : 4
          });
        },
      ), // FloatingActionButton

    );
  }
}

class Student {
  final String name;
  final int roll;

  Student(this.name, this.roll);
}