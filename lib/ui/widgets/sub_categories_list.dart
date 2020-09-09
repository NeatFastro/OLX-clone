import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubCategoriesList extends StatelessWidget {
  final DocumentSnapshot parent;

  const SubCategoriesList({
    this.parent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parent.data()['name']),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('categories')
            .where('parentId', isEqualTo: parent.id)
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
                return Card(
                  child: ListView(
                    children: [
                      // ...snapshot.data.docs
                      //     .map(
                      //       (cat) => ExpansionTile(
                      //         title: Text(cat['name']),
                      //         children: [
                      //           Text(cat['subCategories'] == null
                      //               ? 'no sub categories'
                      //               : cat['subCategories']),
                      //         ],
                      //       ),
                      //     )
                      //     .toList()
                      // for (DocumentSnapshot category in snapshot.data.docs)
                      //   // Text(category['name']),
                      //   ExpansionTile(
                      //     title: Text(category['name']),
                      //     children: [
                      //       if (category['subCategories'] != null)
                      //         for (var subCategory in category['subCategories'])
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(subCategory),
                      //           ),
                      //       Text(category['parent'].runtimeType.toString() ?? 'null'),
                      //     ],
                      //   ),
                      for (DocumentSnapshot category in snapshot.data.docs)
                        // Text(category['name']),
                        ListTile(
                          title: Text(category.data()['name']),
                          // children: [
                          //   if (category['subCategories'] != null)
                          //     for (var subCategory in category['subCategories'])
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Text(subCategory),
                          //       ),
                          //   Text(category['parent'].runtimeType.toString() ?? 'null'),
                          // ],
                          onTap: () {
                            // goto(context, CategoriesList());
                          },
                        ),
                    ],
                  ),
                );
              }
              break;
            default:
              return Text('No payment methos');
          }
        },
      ),
    );
  }
}
