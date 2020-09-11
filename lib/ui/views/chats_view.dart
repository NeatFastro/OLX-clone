import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/chat_room.dart';
import 'package:olx_clone/code/services/data_store.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/chat.dart';

class ChatsList extends StatelessWidget {
//   @override
//   _ChatsListState createState() => _ChatsListState();
// }

// class _ChatsListState extends State<ChatsList> {

  final repo = DataStore();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firestore
          .collection('chats')
          .where('between', arrayContains: auth.currentUser.uid)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: LinearProgressIndicator());
        }
        if (snapshot.data.docs == null) {
          return Center(child: Text('You haven\'t chatted with anyone yet'));
        }
        return ListView(
          children: [
            for (QueryDocumentSnapshot chat in snapshot.data.docs)
              ListTile(
                // title: Text('OLX User'),
                title: Text(chat.data()['correspondingAd']),
                // subtitle: Text('crresponding ad title'),
                subtitle: Text(chat.data()['correspondingAdTitle' ?? 'title']),
                trailing:
                    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                onTap: () async {
                  Ad ad = await repo.getAd(chat.data()['correspondingAd']);
                  // var ad = repo.getAd(chat.data()['correspondingAd']);
                  goto(
                      context,
                      ChatRoom(
                        ad: ad,
                        chat: Chat.fromDocument(chat),
                      ));
                },
              ),
          ],
        );
      },
    );
  }
}
