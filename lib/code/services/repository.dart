import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/user.dart';

class Repository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Ad>> getAds() async {
    QuerySnapshot documents = await _db.collection('ads').get();

    List<Ad> ads = documents.docs.map((doc) => Ad.fromDocument(doc)).toList();

    return ads;
  }

  Future<Ad> getAd(String id) async {
    DocumentSnapshot adDoc = await _db.collection('ads').doc(id).get();
    return Ad.fromDocument(adDoc);
  }

  Future<UserDoc> getUser(String id) async {
    DocumentSnapshot userDoc = await _db.collection('users').doc(id).get();
    UserDoc user = UserDoc.fromDocument(userDoc);
    return user;
  }

  Future<List<Ad>> getFavouriteAds(List ids) async {
    List<Ad> favouriteAds = [];
    // ids.forEach((id) async {
    //   Ad ad = await getAd(id);
    //   favouriteAds.add(ad);
    //   if (favouriteAds.length == ids.length) {
    //     print('lengths became equla');
    //     return favouriteAds;
    //   }
    // });
    for (int i = 0; i < ids.length; i++) {
      Ad ad = await getAd(ids[i]);
      favouriteAds.add(ad);
      if (i == ids.length - 1) {
        return favouriteAds;
      }
    }
    print('this. will execute after the loop');
  }
}
