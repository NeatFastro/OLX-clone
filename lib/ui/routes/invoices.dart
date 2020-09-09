import 'package:flutter/material.dart';
import 'package:olx_clone/ui/widgets/no_invoice.dart';

class Invoices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: NoInvoice(),
    );
  }
}
