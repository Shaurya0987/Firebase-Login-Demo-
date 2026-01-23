import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("ukbs") // ✅ CONFIRMED COLLECTION
              .snapshots(),
          builder: (context, snapshot) {
            // 🔴 Handle errors
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }

            // ⏳ Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 📭 Empty state
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Products Found"));
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                // ✅ SAFE cast
                final Map<String, dynamic> data =
                    docs[index].data() as Map<String, dynamic>? ?? {};

                // ✅ SAFE FIELD EXTRACTION
                final String name =
                    data['name']?.toString() ?? "No Name";

                final int id =int.tryParse(docs[index].id) ?? 0;


                final double price =
                    double.tryParse(data['price']?.toString() ?? '0') ?? 0.0;

                final String description =
                    data['description']?.toString() ?? "No Description";

                final bool isAvailable =
                    data['isAvailable'] == true;

                return ProductCard(
                  productName: name,
                  productId: id,
                  price: price,
                  description: description,
                  isAvailable: isAvailable,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final int productId;
  final double price;
  final String description;
  final bool isAvailable;

  const ProductCard({
    super.key,
    required this.productName,
    required this.productId,
    required this.price,
    required this.description,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Name: $productName",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Product ID: $productId"),
            Text("Price: ₹$price"),
            Text("Description: $description"),
            Text("Available: ${isAvailable ? "Yes" : "No"}"),
          ],
        ),
      ),
    );
  }
}
