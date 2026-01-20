import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselogindemo/Firebase/CRUD_Functions.dart';
import 'package:flutter/material.dart';

class CrudOperationScreen extends StatelessWidget {
  CrudOperationScreen({super.key});

  final CrudFunctions services=CrudFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Database Options"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                services.createData("pets", "kitty", "Cuty", "Cat", 1);
              },
              child: const Text("Create"),
            ),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Read"),
            ),

            ElevatedButton(
              onPressed: () {
                services.updateData("pets", "kitty", "name", "Pussy");
              },
              child: const Text("Update"),
            ),

            ElevatedButton(
              onPressed: () {
                services.deleteData("pets", "kitty");
              },
              child: const Text("Delete"),
            ),

            const Divider(height: 40),

            const Text(
              "Fetching Documents",
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 10),

            // 🔴 VERY IMPORTANT: Expanded
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("pets")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No pets found"),
                    );
                  }

                  final petDocs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: petDocs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        child: ListTile(
                          title: Text(petDocs[index]['name']),
                          subtitle: Text(petDocs[index]['animal']),
                          trailing: Text(
                            petDocs[index]['age'].toString(),style: TextStyle(
                              fontSize: 21
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
