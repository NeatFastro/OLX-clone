import 'package:flutter/material.dart';

import 'package:olx_clone/code/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final VoidCallback onTap;
  final Category category;
  // final String text;

  const CategoryGridItem({
    Key key,
    this.onTap,
    this.category,
    // this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        // onTap: () {
        //   goto(
        //     context,
        //     SubCategoriesList2(
        //       category: category,
        //     ),
        //   );
        // },
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (category == null)
                Icon(Icons.apps)
              else
                Image.network(
                  category.image,
                  width: 32,
                  height: 32,
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category?.name ?? 'More \n Categories',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
