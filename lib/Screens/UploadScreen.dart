import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Upload Images & Files"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){

            }, child: Text("Choose Image")),
            ElevatedButton(onPressed: (){

            }, child: Text("Choose File")),
            ElevatedButton(onPressed: (){

            }, child: Text("Upload Image")),
            ElevatedButton(onPressed: (){

            }, child: Text("Upload File")),
          ],
        ),
      ),
    );
  }
}