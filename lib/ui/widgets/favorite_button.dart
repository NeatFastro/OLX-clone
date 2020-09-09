import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/user.dart';
import 'package:olx_clone/code/services/repository.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/authenticationFlow.dart';

class FavouritesButton extends StatefulWidget {
  final Ad ad;

  const FavouritesButton({
    Key key,
    this.ad,
  }) : super(key: key);

  @override
  _FavouritesButtonState createState() => _FavouritesButtonState();
}

class _FavouritesButtonState extends State<FavouritesButton> {
  bool isFavored = false;
  final repo = Repository();

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    return SizedBox(
      height: 28,
      width: 28,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: Offset(5, 5), // changes position of shadow
              ),
            ],
          ),
          child: user == null || user.isAnonymous
              ? Center(
                child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      goto(context, AuthenticationFow());
                    }),
              )
              : Center(
                child: FutureBuilder<UserDoc>(
                    future: repo.getUser(auth.currentUser.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            height: 48,
                            width: 48,
                            child: Icon(
                              Icons.favorite_border,
                              size: 20,
                            ),
                          ),
                        );
                      }
                      if (snapshot.data.favoriteAds.contains(widget.ad.adId)) {
                        isFavored = true;
                      } else {
                        isFavored = false;
                      }
                      return IconButton(
                        iconSize: 20,
                        icon: isFavored
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        onPressed: () async {
                          setState(() {
                            if (isFavored) {
                              firestore
                                  .collection('users')
                                  .doc(snapshot.data.id)
                                  .update(
                                {
                                  'favoriteAds':
                                      FieldValue.arrayRemove([widget.ad.adId]),
                                },
                              );
                            } else {
                              firestore
                                  .collection('users')
                                  .doc(snapshot.data.id)
                                  .update(
                                {
                                  'favoriteAds':
                                      FieldValue.arrayUnion([widget.ad.adId]),
                                },
                              );
                            }
                          });
                        },
                      );
                    }),
              ),
        ),
      ),
    );
  }
}
