import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_clone/code/ambience/vars.dart';

class UserDoc {
  final String id;
  final String name;
  final String displayName;
  final String email;
  final String photoUrl;
  final List activeAds;
  final bool deletedAccount;
  // final String about;
  // final DateTime joinedAt;
  // final bool deleted;
  // final List steps;
  final String phoneNumber;
  final String memberSince;
  final List following;
  final List followers;
  final List favoriteAds;
  final List chats;

  String share = 'Follow me on #OLX_Clone to see my ads!';

  UserDoc({
    this.chats,
    this.memberSince,
    this.following,
    this.followers,
    this.id,
    this.name,
    this.displayName,
    this.email,
    this.photoUrl,
    // this.about,
    this.activeAds,
    this.deletedAccount = false,
    // this.joinedAt,
    // this.deleted,
    // this.steps,
    this.phoneNumber,
    this.favoriteAds,
  });

  factory UserDoc.fromDocument(DocumentSnapshot document) {
    final Map<String, dynamic> data = document.data();
    if (data == null) {
      return UserDoc(name: 'Name', displayName: 'display name');
    }
    return UserDoc(
      id: document.id,
      name: data['name'] ?? '',
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? noPhotoUrl,
      phoneNumber: data['phoneNumber'] ?? 'your phone number',
      // about: ['about'] ?? '',
      activeAds: data['activeAds'] ?? [],
      favoriteAds: data['favoriteAds'] ?? [],
      followers: data['followers'],
      following: data['following'],
      memberSince: data['memberSince'],
      deletedAccount: data['deletedAccount'] ?? false,
      chats: data['chats'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': this.id,
      'name': this.name,
      'displayName': this.displayName,
      'email': this.email,
      'photoUrl': this.photoUrl,
      'phoneNumber': this.phoneNumber,
      // 'about': this.about,
      'activeAds': this.activeAds,
      'favoriteAds': this.favoriteAds,
      'followers': this.followers,
      'following': this.following,
      'memberSince': this.memberSince,
      // 'memberSince': Timestamp.fromDate(this.memberSince),
      'deletedAccount': this.deletedAccount,
      'chats': this.chats,
    };
  }
}
