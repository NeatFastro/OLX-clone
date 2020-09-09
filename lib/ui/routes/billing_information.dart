import 'package:flutter/material.dart';
import 'package:olx_clone/code/utils.dart';

class BillingInformation extends StatefulWidget {
  @override
  _BillingInformationState createState() => _BillingInformationState();
}

class _BillingInformationState extends State<BillingInformation> {
  List<String> customerTypes = ['BUSINESS', 'RESIDENTIAL'];

  String selectedCustomerType;

  final customerTypeSelectorController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billing Information'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('CUSTOMER INFORMATION'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                controller: customerTypeSelectorController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Customer Type *',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Customer Type'),
                        actions: [
                          for (String customerType in customerTypes)
                            MaterialButton(
                              onPressed: () {
                                selectedCustomerType = customerType;
                                customerTypeSelectorController.text =
                                    selectedCustomerType;
                                pop(context);
                              },
                              child: Text(customerType),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                onSubmitted: (input) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                ),
                onSubmitted: (input) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Business Name',
                ),
                onSubmitted: (input) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                onSubmitted: (input) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Address line 1',
                ),
                onSubmitted: (input) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Address line 1',
                ),
                onSubmitted: (input) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('CUSTOMER ADDRESS'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                controller: customerTypeSelectorController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Customer Type *',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Customer Type'),
                        actions: [
                          for (String customerType in customerTypes)
                            MaterialButton(
                              onPressed: () {
                                selectedCustomerType = customerType;
                                customerTypeSelectorController.text =
                                    selectedCustomerType;
                                pop(context);
                              },
                              child: Text(customerType),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'City',
                ),
                onSubmitted: (input) {},
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            height: 48,
            color: Colors.teal[900],
            onPressed: () {},
            child: Text('Save'),
          ),
        ),
      ),
    );
  }
}
