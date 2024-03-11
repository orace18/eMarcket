import 'package:flutter/material.dart';

class Category {
  final String id;
  final String libelle;
  final String description;
  final String nombres;
  final String? images;

  Category({
    required this.id,
    required this.libelle,
    required this.description,
    required this.nombres,
    required this.images,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      libelle: json['libelle'] ?? '',
      description: json['description'] ?? '',
      nombres: json['nombres'] ?? '',
      images: json['photo'] ?? '',
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final Color color;

  CategoryCard({required this.category, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(category.libelle),
      ),
    );
  }
}
