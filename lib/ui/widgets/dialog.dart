import 'package:flutter/material.dart';
import 'package:olx_clone/code/utils.dart';

class MyDialog extends StatelessWidget {
  final locationState;
  MyDialog({
    Key key,
    this.locationState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Transform.translate(
      offset: Offset(
        screenWidth * -0.07,
        screenHeight * -0.3,
      ),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipPath(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              clipper: MyCustomClipper(),
              child: Container(
                color: Colors.blue,
                height: 13,
              ),
            ),
            ColoredBox(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Device Location off!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => pop(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Text(
                          'Share your current location to easily buy and sell near you.'),
                    ),
                    MaterialButton(
                      // color: Colors.red,
                      onPressed: () {
                        // location.requestService();
                        pop(context);
                        locationState.getCurrentLocation();
                        print('poped dialog box');
                      },
                      child: Text(
                        'Enable Location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationThickness: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // var controlPoint = Offset(size.width / 2, size.height / 2);
    // var endPoint = Offset(size.width, size.height);

    Path path = Path()
      ..moveTo(size.width * .3, 0) // move path point to (w/2,0)
      ..lineTo((size.width * .3) - 10, 14)
      ..lineTo((size.width * .3) + 10, 14)
      ..fillType = PathFillType.nonZero
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
