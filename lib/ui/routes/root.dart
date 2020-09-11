import 'package:flutter/material.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import 'package:olx_clone/ui/routes/chats.dart';
import 'package:olx_clone/ui/routes/explore.dart';
import 'package:olx_clone/ui/routes/my_account.dart';
import 'package:olx_clone/ui/routes/my_ads.dart';
import 'package:olx_clone/ui/routes/sell.dart';
import 'package:olx_clone/ui/widgets/my_bottom_navigation_bar.dart';

class Root extends StatefulWidget {
  static const String route = '/';

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final Explore explore = Explore();
  final Chats chats = Chats();
  // final Sell sell = Sell();
  final MyAds myAds = MyAds();
  final MyAccount myAccount = MyAccount();

  List<Widget> routes;
  Widget currentRoute;
  int currentRouteIndex = 0;

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    routes = [
      explore,
      chats,
      // sell,
      myAds,
      myAccount,
    ];

    currentRoute = routes[currentRouteIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      // endDrawer: AuthenticationFow(),
      body: currentRoute,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goto(context, Sell());
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // bottomNavigationBar: MyBottomNavigationBar(

      //   activeColor: Colors.pinkAccent.shade200,
      //   currentIndex: selectedRoute,
      //   onTap: (routeIndex) {
      //     setState(() {
      //       selectedRoute = routeIndex;
      //       currentRoute = routes[selectedRoute];
      //     });
      //     // if (routeIndex == 3) {
      //     //   print('user is  null');
      //     //   // goto(context, AuthenticationFow());
      //     //   _scaffoldKey.currentState.openEndDrawer();
      //     // }
      //   },
      //   items: const <MyBottomNavigationBarItem>[
      //     MyBottomNavigationBarItem(
      //         icon: Typicons.home_outline,
      //         activeIcon: Typicons.home,
      //         label: 'Home'),
      //     MyBottomNavigationBarItem(
      //         icon: Icons.chat_bubble_outline,
      //         activeIcon: Icons.chat,
      //         label: 'CHATS'),
      //     MyBottomNavigationBarItem(
      //       icon: Typicons.camera_outline,
      //       activeIcon: Typicons.camera,
      //       label: 'SELL',
      //     ),
      //     MyBottomNavigationBarItem(
      //         icon: Icons.content_copy,
      //         activeIcon: Icons.description,
      //         label: 'MY ADS'),
      //     MyBottomNavigationBarItem(
      //         icon: Icons.person_outline,
      //         activeIcon: Icons.person,
      //         label: 'ACCOUNT'),
      //   ],
      // ),
      bottomNavigationBar: BottomAppBar(
        child: MyBottomNavigationBar(
          currentIndex: currentRouteIndex,
          onTap: (routeIndex) {
            print('tapped index is $routeIndex');
            setState(() {
              // if (routeIndex <= 2) {
              //   routeIndex++;
              // }
              currentRouteIndex = routeIndex;
              currentRoute = routes[currentRouteIndex];
            });
            // if (routeIndex == 3) {
            //   print('user is  null');
            //   // goto(context, AuthenticationFow());
            //   _scaffoldKey.currentState.openEndDrawer();
            // }
          },
          items: const <MyBottomNavigationBarItem>[
            MyBottomNavigationBarItem(
              icon: Typicons.home_outline,
              activeIcon: Typicons.home,
              label: 'Home',
            ),
            MyBottomNavigationBarItem(
              icon: Icons.chat_bubble_outline,
              activeIcon: Icons.chat,
              label: 'CHATS',
            ),
            // MyBottomNavigationBarItem(
            //   icon: Icons.chat_bubble_outline,
            //   activeIcon: Icons.chat,
            //   label: 'CHATS',
            // ),
            MyBottomNavigationBarItem(
              icon: Icons.content_copy,
              activeIcon: Icons.description,
              label: 'MY ADS',
            ),
            MyBottomNavigationBarItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'ACCOUNT',
            ),
          ],
        ),
      ),
    );
  }
}
