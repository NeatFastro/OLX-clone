import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olx_clone/code/ambience/providers.dart';
import 'package:olx_clone/code/ambience/vars.dart';
import 'package:olx_clone/code/states/sell_state.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/root.dart';
import 'package:olx_clone/ui/widgets/carousel.dart';

class AdPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, snapshot, _) {
            SellState sellState = snapshot(sellStateProvider);
            return Column(
              children: [
                SizedBox(
                  height: 60,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [brandColor, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              goto(context, Root());
                            }),
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.share_outlined), onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.create_outlined),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ),
                Carousel(sellState.ad),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.remove_red_eye),
                          ),
                          Text(
                            // sellState.ad.views.toString(),
                            '0',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.favorite),
                          ),
                          Text(
                            // sellState.ad.views.toString(),
                            '0',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
