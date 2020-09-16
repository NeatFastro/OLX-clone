import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olx_clone/code/ambience/providers.dart';
import 'package:olx_clone/code/models/category.dart';
import 'package:olx_clone/code/states/sell_state.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/sell.dart';

class SubCategoriesList2 extends StatelessWidget {
  final Category category;

  const SubCategoriesList2({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Consumer(
          // stream: null,
          builder: (context, snapshot, _) {
        SellState sellState = snapshot(sellStateProvider);
        return ListView.separated(
          separatorBuilder: (context, i) => Divider(),
          itemCount: category.subCategories.length,
          itemBuilder: (context, index) {
            // if (category.subCategories[index] == 'View All') {
            //   return SizedBox.shrink();
            // }
            return ListTile(
              title: Text(category.subCategories[index]),
              onTap: () {
                if (category.subCategories[index] != 'View All') {
                  print('tapped on ' + category.subCategories[index]);
                  sellState.category = category.subCategories[index];
                  goto(context, Sell());
                }
              },
            );
          },
        );
      }),
    );
  }
}
