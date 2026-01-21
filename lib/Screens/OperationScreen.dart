import 'package:firebaselogindemo/Firebase/StudentDataBase.dart';
import 'package:firebaselogindemo/Models/Student_Model.dart';
import 'package:flutter/material.dart';

class Operationscreen extends StatefulWidget {
  const Operationscreen({super.key});

  @override
  State<Operationscreen> createState() => _OperationscreenState();
}

class _OperationscreenState extends State<Operationscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  StudentDatabase service = StudentDatabase();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Operation Screen")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      label: Text("Enter Name"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: collegeController,
                    decoration: InputDecoration(
                      label: Text("Enter collge nme"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter College Name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: branchController,
                    decoration: InputDecoration(
                      label: Text("Enter Branch Name"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Branch Name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: semesterController,
                    decoration: InputDecoration(
                      label: Text("Enter  Current Semester"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Semester";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: rollNoController,
                    decoration: InputDecoration(
                      label: Text("Enter  RollNo"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Roll No";
                      }
                      return null;
                    },
                  ),
                ),
            
                ElevatedButton(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      final student = StudentModel(
                      name: nameController.text.trim(),
                      college: collegeController.text.trim(),
                      semester: int.parse(semesterController.text.trim()),
                      branch: branchController.text.trim(),
                      rollNo: int.parse(rollNoController.text.trim()),
                    );
                    service.createStudent("ucbs", rollNoController.text, student);
                    }
                  },
                  child: Text("Create Student"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                    service.updateStudent('ucbs', rollNoController.text, {
                      "name": "Sherry",
                      'branch': 'BBA',
                    });
                  }
                  },
                  child: Text("Update Student"),
                ),
                ElevatedButton(onPressed: () {
                  if(_formKey.currentState!.validate()){
                    
                  }
                }, child: Text("Read Student")),
                ElevatedButton(
                  onPressed: () {
                    service.deleteStudent("ucbs", rollNoController.text);
                  },
                  child: Text("Delete Student"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
