import 'package:flutter/material.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/billing_information.dart';
import 'package:olx_clone/ui/routes/buy_packages.dart';
import 'package:olx_clone/ui/routes/invoices.dart';
import 'package:olx_clone/ui/routes/my_order.dart';

class InvoicesAndBilling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices & Billing'),
      ),
      body: Column(
        children: [
          SizedBox(height: 6),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('Buy Packages'),
            ),
            subtitle:
                Text('Sell faster, more & at higher margins with pakages'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              goto(context, BuyPackages());
            },
          ),
           Divider(),
            ListTile(
            title: Text('My Orders'),
            subtitle: Text('Active, scheduled and expired orders'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              goto(context, MyOrders());
            },
          ),
           Divider(),
          ListTile(
            title: Text('Invoices'),
            subtitle: Text('See and download your invoices'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              goto(context, Invoices());
            },
          ),
           Divider(),
          ListTile(
            title: Text('Billing information'),
            subtitle: Text('Edit your billing name, address, etc'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              goto(context, BillingInformation());
            },
          ),
           Divider(),
        ],
      ),
    );
  }
}
