import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
// import 'package:latlng/latlng.dart';
// import 'package:map/map.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/ambience/vars.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/chat.dart';
import 'package:olx_clone/code/models/userDocument.dart';
import 'package:olx_clone/code/services/data_store.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/authenticationFlow.dart';
import 'package:olx_clone/ui/routes/chat_room.dart';
import 'package:olx_clone/ui/routes/other_user_profile.dart';
import 'package:olx_clone/ui/widgets/ad_tile.dart';
import 'package:olx_clone/ui/widgets/carousel.dart';
import 'package:olx_clone/ui/widgets/favorite_button_simple.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;
import 'package:url_launcher/url_launcher.dart';

class AdDetails extends StatelessWidget {
// final postDate=  DateTime.now().subtract();

  final postDate;
  // final MapController mapController;

  final Ad ad;
  // UserDoc user;
  final data = DataStore();
  AdDetails({Key key, this.ad}) : postDate = DateTime.parse(ad.postedAt);
  // mapController = MapController(
  //     location: LatLng(
  //         ad.adUploadLocation.latitude, ad.adUploadLocation.longitude));

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Carousel(ad),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs ' + ad.price,
                  style: textStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                FavouritesButtonSimple(
                  ad: ad,
                ),
              ],
            ),
            Text(
              ad.title,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.location_on),
                  // Text('location from where the ad was posted'),
                  // Text(ad.adUploadLocation.toString()),
                  FutureBuilder<List<Address>>(
                    future: Geocoder.local.findAddressesFromCoordinates(
                      Coordinates(
                        ad.adUploadLocation.latitude,
                        ad.adUploadLocation.longitude,
                      ),
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicator();
                      else
                        // return Text(snapshot.data[0].subLocality ?? 'Not Available');
                        return Text(snapshot.data[0].locality ?? 'Not Available');
                    },
                  ),
                  Spacer(),
                  // Text('2 days ago'),
                  Text(timeAgo.format(postDate, locale: 'en')),
                ],
              ),
            ),
            Divider(),
            Text(
              'Details',
              style: textStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('MAKER'),
                Text(ad.maker),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('CONDITION'),
                Text(ad.condition),
              ],
            ),
            Divider(),
            Text(
              'Description',
              style: textStyle,
            ),
            Text(ad.description),
            Divider(),
            FutureBuilder(
              future: firestore.collection('users').doc(ad.postedBy).get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Center(child: LinearProgressIndicator());
                }

                if (snapshot.hasData) {
                  final user = UserDocument.fromDocument(snapshot.data);
                  // this.user = user;
                  return ListTile(
                    onTap: () => goto(context, OtherUserProfile(user)),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(user.photoUrl ?? noPhotoUrl),
                    ),
                    title: Text(user.displayName ?? 'wow'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('member since 2020'),
                        Text(
                          'See profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 3,
                            // height: 2,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                }
                return SizedBox();
              },
            ),
            Divider(),
            Text(
              'Ad posted at',
              style: textStyle,
            ),
            SizedBox(
              height: 260,
              // child: Map(
              //   controller: mapController,
              //   provider: CachedGoogleMapProvider(),
              // ),
              child: Placeholder(),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AD ID: 023984572',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'REPORT THIS AD',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Text(
              'Related Ads',
              style: textStyle,
            ),
            FutureBuilder<List<Ad>>(
              future: data.getRelatedAds(ad),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('loading...'));
                }
                // return SizedBox();
                // else
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Ad ad = snapshot.data[index];
                        return AdTile(ad: ad);
                      }),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton.icon(
                    height: 60,
                    color: Colors.teal,
                    onPressed: () {
                      print('initiating chat');
                      if (auth.currentUser == null) {
                        goto(context, AuthenticationFow());
                      } else {
                        bool createNewChat = true;
                        DataStore().getUser(auth.currentUser.uid).then((user) {
                          print('got detail for current user from firestore');
                          if (user.chats != null) {
                            for (dynamic map in user.chats) {
                              if (map.containsValue(ad.adId)) {
                                print('condition evaluated to true');
                                createNewChat = false;
                                firestore
                                    .collection('chats')
                                    .doc(map['chat'])
                                    .get()
                                    .then((chatDocument) {
                                  Chat chat = Chat.fromDocument(chatDocument);
                                  goto(
                                    context,
                                    ChatRoom(
                                      ad: ad,
                                      chat: chat,
                                    ),
                                  );
                                });
                                break;
                              }
                            }
                          }
                          print('will create new chat doc $createNewChat');

                          if (createNewChat == true) {
                            print('going to chat room ');
                            firestore.collection('chats').add(
                              {
                                'between': [auth.currentUser.uid, ad.postedBy],
                                // 'between': {

                                // },
                                'correspondingAd': ad.adId,
                                'correspondingAdTitle': ad.title,
                                'messages': [
                                  {
                                    'from': 'Olx',
                                    'Content':
                                        'Never make payments or send products in advance, to avoid the risk of fraud',
                                    'timeStamp': 'since inception',
                                  }
                                ],
                              },
                            ).then((doc) {
                              firestore
                                  .collection('users')
                                  .doc(auth.currentUser.uid)
                                  .update({
                                'chats': FieldValue.arrayUnion([
                                  {
                                    'type': 'buying',
                                    'ad': ad.adId,
                                    'chat': doc.id,
                                  }
                                ]),
                              });
                              doc.get().then((value) {
                                goto(
                                    context,
                                    ChatRoom(
                                      ad: ad,
                                      chat: Chat.fromDocument(value),
                                    ));
                              });
                            });
                          }
                        });
                      }
                    },
                    icon: Icon(Icons.chat_bubble_outline),
                    label: Text('Chat'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton.icon(
                    height: 60,
                    color: Colors.teal,
                    onPressed: () {},
                    icon: Icon(Icons.mail_outline),
                    label: Text('SMS'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton.icon(
                    height: 60,
                    color: Colors.teal,
                    onPressed: () {
                      // launch();
                    },
                    icon: Icon(Icons.call),
                    label: Text('Call'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CachedGoogleMapProvider extends MapProvider {
//   const CachedGoogleMapProvider();

//   @override
//   ImageProvider getTile(int x, int y, int z) {
//     //Can also use CachedNetworkImageProvider.
//     return NetworkImage(
//         'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425');
//   }
// }
