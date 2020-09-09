import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/user.dart';
import 'package:olx_clone/code/services/repository.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/authenticationFlow.dart';

class FavouritesButtonSimple extends StatefulWidget {
  final Ad ad;
  // final User user;

  const FavouritesButtonSimple({
    Key key,
    this.ad,
    // this.user,
  }) : super(key: key);

  @override
  _FavouritesButtonSimpleState createState() => _FavouritesButtonSimpleState();
}

class _FavouritesButtonSimpleState extends State<FavouritesButtonSimple> {
  bool isFavored = false;
  final repo = Repository();

  @override
  Widget build(BuildContext context) {
    return auth.currentUser.isAnonymous
        ? IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              goto(context, AuthenticationFow());
            })
        : FutureBuilder<UserDoc>(
            // future: auth
            //     .currentUser()
            //     .then((firebaseUser) => repo.getUser(firebaseUser.uid)),
            future: repo.getUser(auth.currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 48,
                  width: 48,
                  child: Icon(
                    Icons.favorite_border,
                    size: 24,
                  ),
                );
              }
              if (snapshot.data.favoriteAds.contains(widget.ad.adId)) {
                isFavored = true;
              } else {
                isFavored = false;
              }
              return IconButton(
                icon: isFavored
                    ? Icon(
                        Icons.favorite,
                      )
                    : Icon(Icons.favorite_border),
                onPressed: () async {
                  setState(() {
                    if (isFavored) {
                      firestore.collection('users').doc(snapshot.data.id).set(
                        {
                          'favoriteAds':
                              FieldValue.arrayRemove([widget.ad.adId]),
                        },
                        SetOptions(merge: true),
                      );
                    } else {
                      firestore.collection('users').doc(snapshot.data.id).set(
                        {
                          'favoriteAds':
                              FieldValue.arrayUnion([widget.ad.adId]),
                        },
                        SetOptions(merge: true),
                      );
                    }
                  });
                },
              );
            });
  }
}
