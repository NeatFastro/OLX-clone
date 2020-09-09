import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/user.dart';
import 'package:olx_clone/code/services/repository.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/authenticationFlow.dart';
import 'package:olx_clone/ui/routes/sell.dart';
import 'package:olx_clone/ui/widgets/ad_tile.dart';

class MyAds extends StatelessWidget {
  final repo = Repository();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Fetching your Ads'));
        }
        if (snapshot.data == null || snapshot.data.isAnonymous) {
          return AuthenticationFow(message: 'your ads');
        } else {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('My Ads'),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: 'ADS',
                    ),
                    Tab(
                      text: 'FAVOURITES',
                    ),
                  ],
                ),
              ),
              // body: FutureBuilder<User>(
              //   future: repo.getUser(snapshot.data.uid),
              //   builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(child: CircularProgressIndicator());
              //     }
              //     if (!snapshot.hasData || snapshot.data == null) {
              //       return Center(child: Text('no data'));
              //     }
              //     return ListView.builder(
              //         itemCount: snapshot.data.activeAds.length,
              //         itemBuilder: (context, index) {
              //           return FutureBuilder<Ad>(
              //             future: repo.getAd(snapshot.data.activeAds[index]),
              //             builder: (BuildContext context, AsyncSnapshot<Ad> ad) {
              //               return AdTile(
              //                 ad: ad.data,
              //               );
              //             },
              //           );
              //         });
              //   },
              // ),
              body: TabBarView(
                children: [
                  FutureBuilder<QuerySnapshot>(
                    future: firestore
                        .collection('ads')
                        .where('postedBy', isEqualTo: snapshot.data.uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data.docs.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text('you have not posted any ads')),
                            MaterialButton(
                              color: Colors.teal,
                              onPressed: () {
                                goto(context, Sell());
                              },
                              child: Text('Post now'),
                            ),
                          ],
                        );
                      }
                      // return ListView(
                      //   children: snapshot.data.docs.map((adDoc) {
                      //     var ad = Ad.fromDocument(adDoc);
                      //     return AdTile(
                      //       ad: ad,
                      //     );
                      //   }).toList(),
                      // );

                      return ListView(
                        children: [
                          for (QueryDocumentSnapshot doc in snapshot.data.docs)
                            AdTile(ad: Ad.fromDocument(doc)),
                        ],
                      );
                    },
                  ),
                  //  favourites tab viewlogic starts here
                  FutureBuilder<UserDoc>(
                    future: repo.getUser(snapshot.data.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Center(
                            child: Text('you have not favored any ads'));
                      }
                      // return ListView(
                      //   children: snapshot.data.favoriteAds.map((adDoc) {
                      //     var ad = Ad.fromDocument(adDoc);
                      //     return AdTile(
                      //       ad: ad,
                      //     );
                      //   }).toList(),
                      // );
                      return FutureBuilder<List<Ad>>(
                          future:
                              repo.getFavouriteAds(snapshot.data.favoriteAds),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData || snapshot.data == null) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child:
                                          Text('you have not favored any ads')),
                                  MaterialButton(
                                    color: Colors.teal,
                                    onPressed: () {
                                      goto(context, Sell());
                                    },
                                    child: Text('Browes ads'),
                                  ),
                                ],
                              );
                            } else {
                              //   return AdTile(ad: snapshot.data);
                              // }
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return AdTile(ad: snapshot.data[index]);
                                },
                              );
                            }
                          });
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
