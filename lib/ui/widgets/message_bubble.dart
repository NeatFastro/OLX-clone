import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/ambience/vars.dart';
import 'package:olx_clone/code/models/userDocument.dart';

class MessageBubble extends StatelessWidget {
  final String from;
  final String text;
  final UserDocument currentUser;
  // final String timeStamp;

  final bool me;

  const MessageBubble({
    Key key,
    // this.timeStamp,
    this.from,
    this.text,
    this.currentUser,
    this.me,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Material(
            color: me ? Colors.indigo[200] : Colors.grey[400],
            borderRadius: BorderRadius.circular(4),
            elevation: 6.0,
            child: SizedBox(
              child: Column(
                crossAxisAlignment:
                    me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: LimitedBox(
                        maxWidth: MediaQuery.of(context).size.width * .7,
                        child: Text(text)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.check,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          if (me)
            CircleAvatar(
              backgroundImage:
                  NetworkImage(auth.currentUser.photoURL ?? noPhotoUrl),
            ),
        ],
      ),
    );
  }
}
