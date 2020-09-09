import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/widgets/categories_list.dart';

class CategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('categories')
          .where('parentId', isEqualTo: 'null')
          .limit(9)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(child: Text('No Connection'));
            break;
          case ConnectionState.waiting:
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
            break;
          case ConnectionState.active:
            return Center(child: Text('connection is active'));
            break;
          case ConnectionState.done:
            if (snapshot.hasError || !snapshot.hasData) {
              return Text(snapshot.error);
            } else {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 410),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Center(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 10, 7, 0),
                                    child: Text(
                                      'Browse categories',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
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
                          for (int row = 0; row < 3; row++)
                            SizedBox(
                              height: 90,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (int item = 0; item < 3; item++)
                                    CategoryGridItem(
                                      data:
                                          snapshot.data.docs[item + (row * 3)],
                                      colorIndex: item + (row * 3),
                                    )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            break;
          default:
            return Text('No payment methos');
        }
      },
    );
  }
}

class CategoryGridItem extends StatelessWidget {
  final DocumentSnapshot data;
  final int colorIndex;

  const CategoryGridItem({this.data, this.colorIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 100,
        // width: MediaQuery.of(context).size.width * .25,
        width: 70,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.accents[item],
                  color: Colors.accents[colorIndex],
                ),
                child: Image.network(
                  // snapshot.data
                  //         .docs[item + (row * 3)]
                  //     ['image'],
                  data.data()['image'],
                  width: 32,
                  height: 32,
                ),
              ),
              Text(
                data.data()['name'],
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
