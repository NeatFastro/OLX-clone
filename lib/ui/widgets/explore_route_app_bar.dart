import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olx_clone/code/ambience/providers.dart';
import 'package:olx_clone/code/states/location_state.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/location.dart';
import 'package:olx_clone/ui/routes/app_notifications_setting.dart';
import 'package:olx_clone/ui/routes/search.dart';

class ExploreRouteAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: InkWell(
        onTap: () {
          goto(context, Location());
        },
        child: Row(
          children: [
            Icon(Icons.location_on),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Consumer(
                builder: (context, watch, child) {
                  print('explore page title changed');
                  final LocationState locationState =
                      watch(locationStateProvider);
                  return Text(
                    locationState.currentAddress?.featureName ??
                        locationState.currentAddress?.locality ??
                        'Pakistan',
                  );
                },
              ),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      floating: true,
      pinned: true,
      forceElevated: true,
      // snap: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                child: GestureDetector(
                  onTap: () {
                    // showMenu();
                    showSearch(context: context, delegate: Search());
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                        Consumer(
                            // stream: null,
                            builder: (context, provider, child) {
                          var exploreState = provider(exploreStateProvider);
                          return Text(exploreState.searchTerms);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => goto(context, AppNotificationsSetting()),
            ),
          ],
        ),
      ),
    );
  }
}
