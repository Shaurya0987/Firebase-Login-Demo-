import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Profile Screen")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("ucbs").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Students Found"));
            }

            final studentDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: studentDocs.length,
              itemBuilder: (context, index) {
                return ContainerWidget(
                  name: studentDocs[index]['name'],
                  college: studentDocs[index]['college'],
                  branch: studentDocs[index]['branch'],
                  rollNo: studentDocs[index]['rollNo'],
                  semester: studentDocs[index]['semester'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String name;
  final String college;
  final String branch;
  final int rollNo;
  final int semester;
  const ContainerWidget({
    super.key,
    required this.name,
    required this.college,
    required this.branch,
    required this.rollNo,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(10),
        // height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(name),
            Text(college),
            Text(semester.toString()),
            Text(branch),
            Text(rollNo.toString()),
          ],
        ),
      ),
    );
  }
}
