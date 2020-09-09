import 'package:flutter/material.dart';

class ChooseAnOption extends StatefulWidget {
  @override
  _ChooseAnOptionState createState() => _ChooseAnOptionState();
}

class _ChooseAnOptionState extends State<ChooseAnOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Choose an option'),
              // floating: true,
              pinned: true,
              // forceElevated: true,
              // snap: true,
              expandedHeight: 260,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FittedBox(
                          child: Icon(
                            Icons.directions_boat,
                            size: 120,
                          ),
                        ),
                        FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Heavy discount on Packages',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                // color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              // delegate: SliverChildBuilderDelegate(
              //   (context, index) {
              //     return Center(
              //       child: Padding(
              //         padding: const EdgeInsets.all(16.0),
              //         child: Text('child # $index'),
              //       ),
              //     );
              //   },
              //   childCount: 100,
              // ),
              delegate: SliverChildListDelegate(
                [
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
