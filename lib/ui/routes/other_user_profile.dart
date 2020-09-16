import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/vars.dart';
import 'package:olx_clone/code/models/ad.dart';

import 'package:olx_clone/code/models/userDocument.dart';
import 'package:olx_clone/code/services/data_store.dart';
import 'package:olx_clone/ui/widgets/ad_tile.dart';

class OtherUserProfile extends StatefulWidget {
  final UserDocument user;

  const OtherUserProfile(this.user);

  @override
  _OtherUserProfileState createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  UserDocument user;
  final DataStore data = DataStore();

  @override
  void initState() {
    // TODO: implement initState
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 50,
                  // backgroundImage: NetworkImage(user.photoUrl),
                  child: Text(
                    user.displayName.substring(0, 1) ?? 'null',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(user.following?.length?.toString() ?? '0'),
                              Text('FOLLOWING'),
                            ],
                          ),
                          // Divider(),
                          VerticalDivider(
                            thickness: 10,
                          ),
                          Column(
                            children: [
                              Text(user.followers?.length?.toString() ?? '0'),
                              Text('FOLLOWERS'),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {
                            data.updateMyFollowingList(context, user);
                            data.updateOtherUserFollowersList(user);
                            setState(() {});
                          },
                          minWidth: double.infinity,
                          color: brandColor,
                          textColor: Colors.white,
                          child: Text('Follow'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'View and edit profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 3,
                    // height: 2,
                  ),
                ),
                Divider(),
                // SizedBox(
                //   height: 400,
                //   child: Column(
                //     children: [
                //       Text('Published ads'),
                //       SizedBox(
                //         height: 300,
                //         child: FutureBuilder<List<Ad>>(
                //           future: data.getUserAds(user.id),
                //           builder: (context, snapshot) {
                //             if (!snapshot.hasData){

                //               return Center(child: Text('loading...'));
                //             }
                //               // return SizedBox();
                //             // else
                //               return SizedBox(
                //                 height: 200,
                //                 child: ListView.builder(
                //                     scrollDirection: Axis.horizontal,
                //                     itemCount: snapshot.data.length,
                //                     itemBuilder: (context, index) {
                //                       Ad ad = snapshot.data[index];
                //                       return AdTile(ad: ad);
                //                     }),
                //               );
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          FutureBuilder<List<Ad>>(
            future: data.getUserAds(user.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('loading...'));
              }
              // return SizedBox();
              // else
              return SizedBox(
                height: 250,
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
    );
  }
}
