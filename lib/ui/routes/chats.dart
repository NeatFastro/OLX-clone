import 'package:flutter/material.dart';
import 'package:olx_clone/ui/views/chats_view.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          centerTitle: false,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'ALL',
              ),
              Tab(
                text: 'BUYING',
              ),
              Tab(
                text: 'SELLING',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ChatsView(),
            ChatsList(),
            Text('data'),
            Text('data'),
          ],
        ),
      ),
    );
  }
}
