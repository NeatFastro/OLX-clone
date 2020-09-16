import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final String parentId;
  final List subCategories;

  Category({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.subCategories,
  });

  factory Category.fromDoc(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data();

    return Category(
      id: document.id,
      name: data['name'],
      image: data['image'],
      parentId: data['parentId'] ?? null,
      subCategories: data['subCategories'] == null ? [] : data['subCategories'],
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, image: $image, parentId: $parentId, subCategories: $subCategories)';
  }
}
