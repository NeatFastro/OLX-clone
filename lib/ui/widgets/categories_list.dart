import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/widgets/sub_categories_list.dart';

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('categories')
            .where('parentId', isEqualTo: 'null')
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
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var category = snapshot.data.docs[index];
                      return ListTile(
                        leading: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.accents[index],
                          ),
                          child: Image.network(
                            category.data()['image'],
                            width: 32,
                            height: 32,
                          ),
                        ),
                        title: Text(category.data()['name']),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                        ),
                        onTap: () {
                          goto(context, SubCategoriesList(parent: category));
                        },
                      );
                    },
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
