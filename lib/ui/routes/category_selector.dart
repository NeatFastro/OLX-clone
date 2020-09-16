import 'package:flutter/material.dart';
import 'package:olx_clone/code/models/category.dart';
import 'package:olx_clone/code/services/data_store.dart';
import 'package:olx_clone/code/utils.dart';
// import 'package:olx_clone/ui/widgets/categories_grid.dart';
import 'package:olx_clone/ui/widgets/category_grid_item.dart';

import 'package:olx_clone/ui/widgets/categories_list.dart';
import 'package:olx_clone/ui/widgets/sub_categories_list_2.dart';

class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
            title: Text('What are you offering?'),
          ),
          body: FutureBuilder<List<Category>>(
              future: DataStore().getMainCategories(7),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      for (Category category in snapshot.data)
                        CategoryGridItem(
                          category: category,
                          onTap: () {
                            // sellState.category = category.name;
                            goto(
                              context,
                              SubCategoriesList2(
                                category: category,
                              ),
                            );
                          },
                        ),
                      CategoryGridItem(
                        onTap: () {
                          goto(context, CategoriesList());
                        },
                      ),
                    ],
                  ),
                );
              }),
      
    );
  }
}