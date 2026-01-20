import 'package:firebaselogindemo/Models/name_Model.dart';
import 'package:flutter/material.dart';

class SimpleModelScreen extends StatefulWidget {
  const SimpleModelScreen({super.key});

  @override
  State<SimpleModelScreen> createState() => _SimpleModelScreenState();
}

class _SimpleModelScreenState extends State<SimpleModelScreen> {

  List<NamesModel>namesList=[
    NamesModel(name: "Shaurya", age: 12,profession: "Developer"),
    NamesModel(name: "Sameer", age: 13, profession: "Doctor"),
    NamesModel(name: "Aryan", age: 14, profession: "Dentist"),
    NamesModel(name: "Saransh", age: 15, profession: "Decorist"),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Model Classes"),
      ),
      body: ListView.builder(
        itemCount: namesList.length,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text(namesList[index].name.toString()),
          subtitle: Text(namesList[index].profession.toString()),
          trailing: IconButton(onPressed: (){
            setState(() {
              namesList.removeAt(index);
            });
          }, icon: Icon(Icons.delete,color: Colors.red,)),
        );
      },),
    );
  }
} 
