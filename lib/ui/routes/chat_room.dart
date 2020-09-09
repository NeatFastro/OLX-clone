import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/models/chat.dart';
import 'package:olx_clone/code/models/user.dart';
import 'package:olx_clone/code/services/repository.dart';
import 'package:olx_clone/ui/widgets/message_bubble.dart';

class ChatRoom extends StatefulWidget {
  final Ad ad;
  final Chat chat;

  const ChatRoom({Key key, this.ad, this.chat}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final Repository repo = Repository();
  // UserDoc user;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> send() async {
    if (messageController.text.length > 0) {
      // await firestore.collection('messages').add({
      //   'text': messageController.text,
      //   'from': auth.currentUser.email,
      //   'date': DateTime.now().toIso8601String().toString(),
      // });
      await firestore.collection('chats').doc(widget.chat.id).update({
        'messages': FieldValue.arrayUnion([
          {
            'from': auth.currentUser.email,
            'content': messageController.text,
            'date': DateTime.now().toIso8601String().toString(),
          }
        ]),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  final textStyle = TextStyle(fontSize: 10);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDoc>(
      future: repo.getUser(widget.ad.postedBy),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        UserDoc user = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                SizedBox(
                  width: 66,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(widget.ad.images[0]),
                      ),
                      Image.network(
                        user.photoUrl,
                        // scale: .01,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                FittedBox(
                    child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        user.name,
                        style: textStyle,
                      ),
                    ),
                    Text(
                      'last seen',
                      style: textStyle,
                    ),
                  ],
                )),
              ],
            ),
            actions: [
              IconButton(icon: Icon(Icons.outlined_flag), onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.ad.title),
                    Text(widget.ad.price),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<DocumentSnapshot>(
                    stream: firestore
                        .collection('chats')
                        .doc(widget.chat.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      Chat chat = Chat.fromDocument(snapshot.data);

                      return ListView(
                        controller: scrollController,
                        children: [
                          for (int i = 0; i < chat.messages.length; i++)
                            // Text(chat.messages[i].content)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MessageBubble(
                                from: chat.messages[i].from,
                                text: chat.messages[i].content,
                                me: auth.currentUser.email ==
                                    chat.messages[i].from,
                                // currentUser: ,
                              ),
                            ),
                        ],
                      );
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type here',
                        prefixIcon: Icon(Icons.attachment),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: send,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}


