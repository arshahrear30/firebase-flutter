import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseStudentApp extends StatelessWidget { //root widget (entry point)
  const FirebaseStudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(//MaterialApp দিয়ে Material Design theme সেট করে, এবং StudentListকে home হিসেবে দেয়
      home: StudentList(),
    );
  }
}

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => StudentListState();
}

class StudentListState extends State<StudentList> { //StudentListState -- Data Fetching Strategy

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance; //Firebase এর সাথে সংযোগ
  late CollectionReference studentCollectionRef = firebaseFirestore.collection('students');
  List<Student> studentList = [];


  Future <void> getStudentData()  async { //getStudentData() — One-time fetch (pull-based)
     studentList.clear();
     final QuerySnapshot result =
     await studentCollectionRef.get();
     print(result.size);
     for (QueryDocumentSnapshot element in result.docs) {
       Student student = Student(element.get('name'),
           int.tryParse( element.get('roll').toString())?? 0);
       studentList.add(student);
     }
     if (mounted) {
       setState(() {});
     }

  }

  @override
  void initState() {
    super.initState();
    //getStudentData();
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


        child: StreamBuilder( //StreamBuilder সেই stream শুনতে থাকে এবং UI auto-rebuild করে।
          stream: studentCollectionRef.snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {//waiting গোল গোল লোডিং চাকা
              //Firestore-এ যখনই data change হয় (add/update/delete), Flutter automatically নতুন snapshot পাঠায়।
              //.snapshots() একটা infinite stream তৈরি করে।
              return const Center(
                child: CircularProgressIndicator(),//// লোডিং চাকা
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              studentList.clear();
              for (QueryDocumentSnapshot element in snapshot.data!.docs) {
                Student student = Student(element.get('name'),
                    int.tryParse( element.get('roll').toString())?? 0);
                studentList.add(student);
              }
              return ListView.builder(
                  itemCount: studentList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(studentList[index].roll.toString()),
                      ),
                      title: Text(studentList[index].name),
                    );
                  });
            }
            return const SizedBox();
          }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          studentCollectionRef.add({
            'name' : 'Shahrear',
            'roll' : 11
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