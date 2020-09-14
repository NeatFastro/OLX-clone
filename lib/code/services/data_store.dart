import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/userDocument.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/authenticationFlow.dart';

class DataStore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Ad>> getAds() async {
    QuerySnapshot documents = await _db.collection('ads').get();
    return documents.docs.map((doc) => Ad.fromDocument(doc)).toList();
  }

  Future<List<Ad>> getRelatedAds(Ad ad) async {
    QuerySnapshot querySnapshot = await _db
        .collection('ads')
        .where('title', isEqualTo: ad.title)
        .limit(5)
        .get();

    print('related cats are');
    print(querySnapshot.docs);

    return querySnapshot.docs.map((doc) => Ad.fromDocument(doc)).toList();
  }

  updateOtherUserFollowersList(UserDocument otherUser) async {
    UserDocument user = await getUser(auth.currentUser.uid);
    _db.collection('users').doc(otherUser.id).update({
      'followers': FieldValue.arrayUnion([
        {
          'id': user.id,
          'name': user.name,
        }
      ]),
    });
  }

  updateMyFollowingList(BuildContext context, UserDocument otherUser) async {
    if (auth.currentUser.isAnonymous) {
      goto(context, AuthenticationFow());
    } else {
      _db.collection('users').doc(auth.currentUser.uid).update({
        'following': FieldValue.arrayUnion([
          {
            'id': otherUser.id,
            'name': otherUser.name,
          }
        ]),
      });
    }
  }

// check if user is online or not
  checkUserStatus(String id) {
    _db.collection('users').doc(id).get().then((doc) {
      // UserDocument userDoc = UserDocument.fromDocument(doc);
    });
  }

  Future<Ad> getAd(String id) async {
    DocumentSnapshot adDoc = await _db.collection('ads').doc(id).get();
    return Ad.fromDocument(adDoc);
  }

  Future<UserDocument> getUser(String id) async {
    DocumentSnapshot userDoc = await _db.collection('users').doc(id).get();
    UserDocument user = UserDocument.fromDocument(userDoc);
    return user;
  }

  Future<List<Ad>> getFavouriteAds(List ids) async {
    List<Ad> favouriteAds = [];
    // ids.forEach((id) async {
    //   Ad ad = await getAd(id);k
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

  Future<List<Ad>> getUserAds(String id) async {
    QuerySnapshot querySnapshot =
        await _db.collection('ads').where('postedBy', isEqualTo: id).get();

    return querySnapshot.docs.map((doc) => Ad.fromDocument(doc)).toList();
  }
}
