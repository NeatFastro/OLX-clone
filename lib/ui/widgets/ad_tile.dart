import 'package:flutter/material.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/ad_details.dart';
import 'package:olx_clone/ui/widgets/favorite_button.dart';

class AdTile extends StatelessWidget {
  // final UserDoc user;
  final Ad ad;

  const AdTile({
    Key key,
    // this.user,
    this.ad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goto(context, AdDetails(ad: ad)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 100,
            maxWidth: 200,
            minHeight: 100,
            maxHeight: 200,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.network(ad.images[0]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColoredBox(
                              color: Colors.yellow,
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'FEATURED',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            FavouritesButton(
                              ad: ad,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Rs. ' + ad.price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      ad.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.location_on, size: 14),
                        Expanded(
                          child: Text(
                            ad.postedAt.toString(),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
