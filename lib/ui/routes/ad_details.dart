import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/ambience/vars.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/chat.dart';
import 'package:olx_clone/code/models/user.dart';
import 'package:olx_clone/code/services/repository.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/authenticationFlow.dart';
import 'package:olx_clone/ui/routes/chat_room.dart';
import 'package:olx_clone/ui/routes/profile.dart';
import 'package:olx_clone/ui/widgets/carousel.dart';
import 'package:olx_clone/ui/widgets/favorite_button_simple.dart';

class AdDetails extends StatelessWidget {
  final Ad ad;
  // UserDoc user;

  AdDetails({Key key, this.ad}) : super(key: key);

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
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.location_on),
                Text('location from where the ad was posted'),
                Spacer(),
                Text('2 days ago'),
              ],
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
                  final user = UserDoc.fromDocument(snapshot.data);
                  // this.user = user;
                  return ListTile(
                    // isThreeLine: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child:
                          // Image.network(snapshot.data['photoUrl'] ?? noPhotoUrl),
                          Image.network(user.photoUrl ?? noPhotoUrl),
                      // Image.network(noPhotoUrl),
                    ),
                    // title: Text(snapshot.data['displayName']),
                    title: Text(user.displayName ?? 'wow'),
                    // subtitle: Text(snapshot.data[]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('member since 2020'),
                        GestureDetector(
                          onTap: () {
                            goto(context, Profile(user));
                          },
                          child: Text(
                            'See profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationThickness: 3,
                              // height: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                }
                return Container();
              },
            ),
            Divider(),
            Text(
              'Ad posted at',
              style: textStyle,
            ),
            SizedBox(
              height: 260,
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
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i = 0; i < 10; i++)
                    ColoredBox(
                      color: Colors.accents[i],
                      child: SizedBox(
                        // height: 100,
                        width: 200,
                        child: Center(
                          child: Text('ad #$i'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton.icon(
                color: Colors.teal,
                onPressed: () {
                  print('initiating chat');
                  if (auth.currentUser == null) {
                    goto(context, AuthenticationFow());
                  } else {
                    bool createNewChat = true;
                    Repository().getUser(auth.currentUser.uid).then((user) {
                      print('got detail for current user from firestore');
                      if (user.chats != null) {
                        for (Map map in user.chats) {
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
              FlatButton.icon(
                color: Colors.teal,
                onPressed: () {},
                icon: Icon(Icons.mail_outline),
                label: Text('SMS'),
              ),
              FlatButton.icon(
                color: Colors.teal,
                onPressed: () {},
                icon: Icon(Icons.call),
                label: Text('Call'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
