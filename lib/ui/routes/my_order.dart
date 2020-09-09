import 'package:flutter/material.dart';
import 'package:olx_clone/ui/widgets/no_active_package.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'ACTIVE',
              ),
              Tab(
                text: 'SCHEDULED',
              ),
              Tab(
                text: 'EXPIRED',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NoActicePackage(),
            NoActicePackage(),
            NoActicePackage(),
          ],
        ),
      ),
    );
  }
}
