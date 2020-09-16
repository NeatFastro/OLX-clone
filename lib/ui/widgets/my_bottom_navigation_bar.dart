import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final List<MyBottomNavigationBarItem> items;

  final ValueChanged<int> onTap;
  final int currentIndex;

  // animation login
  // AnimationController animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));

  const MyBottomNavigationBar({
    this.items,
    this.onTap,
    this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * .20;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < items.length; i++)
          InkWell(
            onTap:  () => onTap(i),
            child: currentIndex == i
                ? SizedBox(
                    width: itemWidth,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[i].activeIcon,
                          size: 26,
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 10, end: 14),
                          duration: Duration(milliseconds: 200),
                          builder: (context, value, _) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                items[i].label,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: value,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: itemWidth,
                    height: 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          items[i].icon,
                          size: 20,
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 14, end: 10),
                          duration: Duration(milliseconds: 250),
                          builder: (context, value, _) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                items[i].label,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: value,
                                  // fontWeight: FontWeight.lerp(
                                  //     FontWeight.w700, FontWeight.w400, value * 10),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
      ],
    );
  }
}

class MyBottomNavigationBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const MyBottomNavigationBarItem({
    this.icon,
    this.activeIcon,
    this.label,
  });
}
