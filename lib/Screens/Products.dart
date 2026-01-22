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
        padding: const EdgeInsets.all(28.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("ukbs") // ✅ correct collection
              .snapshots(),
          builder: (context, snapshot) {
            // ⏳ Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ❌ No data
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Products Found..."));
            }

            final products = snapshot.data!.docs;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                // 🔐 SAFE map extraction
                final data =
                    products[index].data() as Map<String, dynamic>? ?? {};

                return ProductCard(
                  productName: data['name'] ?? "No Name",
                  productId: (data['id'] ?? 0) is int
                      ? data['id']
                      : int.tryParse(data['id']?.toString() ?? '0') ?? 0,
                  price: (data['price'] is num)
                      ? (data['price'] as num).toDouble()
                      : 0.0,
                  description: data['description'] ?? "No Description",
                  isAvailable: data['isAvailable'] ?? fals,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product Name : $productName"),
            Text("Product Id : $productId"),
            Text("Price : ₹$price"),
            Text("Description : $description"),
            Text("Available : ${isAvailable ? "Yes" : "No"}"),
          ],
        ),
      ),
    );
  }
}
