import 'package:flutter/material.dart';

class NoActicePackage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 316,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 40),
            Icon(
              Icons.search,
              size: 260.0,
            ),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Nothing here...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    // color: Colors.black,
                  ),
                ),
              ),
            ),
            Text('Your don\'t have any active packages'),
          ],
        ),
      ),
    );
  }
}
