import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/vars.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/ad_preview.dart';
import 'package:olx_clone/ui/routes/buy_packages.dart';

class Congrats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ColoredBox(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Icon(
                      Icons.check_circle_outline,
                      size: 60,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'CONGRATULATIONS!',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Your Ad will go live shortly...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ColoredBox(
                color: Colors.greenAccent[100],
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child:
                        Text('OLX allows 1 free Ad in 1 days for //category'),
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                child: Icon(
                  Icons.local_offer,
                  color: Colors.yellow,
                  size: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Reach more buyers and sell faster',
                  style: TextStyle(
                    // fontSize: 36,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                ),
              ),
              Text('Upgrading an ad helps you to reach more buyers'),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: MaterialButton(
                  color: brandColor,
                  textColor: Colors.white,
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {
                    goto(context, BuyPackages());
                  },
                  child: Text('Sell Faster Now'),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: OutlineButton(
                  color: brandColor,
                  onPressed: () {
                    goto(context, AdPreview());
                  },
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text('Preview Ad'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
