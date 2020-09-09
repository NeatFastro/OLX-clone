import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/services/repository.dart';
import 'package:olx_clone/code/states/location_state.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:location/location.dart';
import 'package:olx_clone/ui/widgets/ad_tile.dart';
import 'package:olx_clone/ui/widgets/categories_grid.dart';
import 'package:olx_clone/ui/widgets/categories_list.dart';
import 'package:olx_clone/ui/widgets/dialog.dart';
import 'package:olx_clone/ui/widgets/explore_route_app_bar.dart';

class Explore extends StatefulWidget {
  static const String route = '/explore';

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  User user;
  List ads = [];
  List catergoryItems = [];
  Repository repository = Repository();

  fetchCategoryItems() {
    firestore
        .collection('categories')
        .where('parentId', isEqualTo: 'null')
        .limit(9)
        .get()
        .then((items) {
      print(items);
      catergoryItems.addAll(items.docs);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryItems();

    repository.getAds().then((ads) {
      setState(() {
        this.ads.addAll(ads);
      });
    });

    // getUser();
    scheduleMicrotask(() => notifyIfLocationIsOff());
  }

  notifyIfLocationIsOff() async {
    final Location location = Location();
    final LocationState locationState = LocationState();

    if (await location.serviceEnabled()) {
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return MyDialog(locationState: locationState);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        ExploreRouteAppBar(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 150,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 7, 0),
                          child: Text(
                            'Browse categories',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            goto(context, CategoriesList());
                          },
                          child: Text(
                            'See all',
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
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < catergoryItems.length; i++)
                        CategoryGridItem(
                          data: catergoryItems[i],
                          colorIndex: i,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kIsWeb ? 3 : 2),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Ad ad = ads[index];
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: 400),
                child: AdTile(ad: ad),
              );
            },
            childCount: ads.length,
          ),
        ),
      ],
    );
  }
}
