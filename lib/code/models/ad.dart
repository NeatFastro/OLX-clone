import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_clone/code/ambience/vars.dart';

class Ad {
  final String adId;
  final String postedBy;
  final String title;
  final String price;
  final String maker;
  final String model;
  final String year;
  final String condition;
  final String description;
  final List images;
  // approx location (lang, lat) of where the ad was posted
  final String postedAt;
  // final DateTime postedDate;
  final GeoPoint adUploadLocation;
  final List chats;

  const Ad({
    this.adId,
    this.postedBy,
    this.title,
    this.price,
    this.maker,
    this.model,
    this.year,
    this.condition,
    this.description,
    this.images,
    this.postedAt,
    this.chats,
    // this.postedDate,
    this.adUploadLocation,
  });

  factory Ad.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data();
    return Ad(
      adId: document.id,
      title: data['title'] ?? 'no title',
      price: data['price'] ?? '',
      maker: data['maker'] ?? '',
      model: data['model'] ?? '',
      year: data['year'] ?? '',
      condition: data['condition'] ?? '',
      description: data['description'] ?? '',
      postedBy: data['postedBy'] ?? '',
      postedAt: data['postedAt'] ?? 'unknown post date',
      // images: data['images']?? ['https://ppc.tools/wp-content/themes/ppctools/img/no-thumbnail.jpg'],
      images:
          (data['images'] as List).isEmpty ? [noTumbnailUrl] : data['images'],
      chats: data['chats'] ?? [],
      adUploadLocation: data['adUploadLocation'] ?? GeoPoint(12, 12),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'adId': this.adId,
      'postedBy': this.postedBy,
      'title': this.title,
      'price': this.price,
      'maker': this.maker,
      'model': this.model,
      'year': this.year,
      'condition': this.condition,
      'description': this.description,
      'images': this.images,
      // 'postedAt': this.postedAt?.millisecondsSinceEpoch,
      'postedAt': this.postedAt,
      'chats': this.chats,
      'adUploadLocation': this.adUploadLocation,
    };
  }
}
