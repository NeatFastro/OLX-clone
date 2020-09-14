import 'package:flutter/material.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/ui/widgets/favorite_button_simple.dart';

class FavouriteAdTile extends StatelessWidget {
  final Ad ad;

  const FavouriteAdTile({Key key, this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        ad.images[0],
        width: 60,
      ),
      title: Text('Rs. ' + ad.price),
      subtitle: Text(ad.title),
      trailing: FavouritesButtonSimple(ad: ad),
    );
  }
}
