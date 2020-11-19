import 'package:flutter/material.dart';
// import 'package:craxyshop/code/models/image.dart' as imageModel;
import 'package:olx_clone/code/models/ad.dart';

class Carousel extends StatefulWidget {
  // final List<imageModel.Image> images;

  // const Carousel(this.images);

  final Ad ad;

  const Carousel(this.ad);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentPage = 0;
  PageController pageController;

  ScrollController imagesListCtrl;
  final double offSet = 200;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    // imagesListCtrl = ScrollController(
    //   initialScrollOffset: 3,
    //   keepScrollOffset: true,
    //   debugLabel: 'i am debug label',
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
            children: <Widget>[
              for (int i = 0; i < widget.ad.images.length; i++)
                Image.network(
                  widget.ad.images[i],
                  width: MediaQuery.of(context).size.width,
                ),
            ],
          ),
          Positioned(
            bottom: 5,
            right: 0,
            left: 0,
            child: SingleChildScrollView(
                          child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int count = 0; count < widget.ad.images.length; count++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        color: count == currentPage ? Colors.black : Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Text('${currentPage + 1}/${widget.ad.images.length}'),
          ),
        ],
      ),
    );
  }
}
