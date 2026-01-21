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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child:Container(
            padding: EdgeInsets.all(10),
              // height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  Text("Shaurya Thakur"),
                  Text("Himachal Pradesh University"),
                  Text("BCA"),
                  Text("Computer Science"),
                  Text("2nd Semester"),
                ],
              ),
            )
          
        ),
      ),
    );
  }
}