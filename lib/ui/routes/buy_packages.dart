import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olx_clone/code/ambience/providers.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/choose_an_option.dart';
import 'package:olx_clone/ui/widgets/categories_list.dart';

class BuyPackages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Packages'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'SELECT OPTIONS TO SHOW PACKAGES',
                // maxLines: 1,
                // softWrap: false,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Colors.black,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Categories'),
            subtitle: Text('Search categories'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              goto(context, CategoriesList());
            },
          ),
          Divider(),
          ListTile(
            title: Text('Location'),
            //TODO make subtitle dynamic
            subtitle: Consumer(
                // stream: null,
                builder: (context, read, _) {
              final state = read(locationStateProvider);
              return Text(state.currentAddress?.adminArea ?? 'Pakistan');
            }),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // goto(context, InvoicesAndBilling());
            },
          ),
          Divider(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                goto(context, ChooseAnOption());
              },
              color: Colors.teal,
              height: 40,
              minWidth: double.infinity,
              child: Text('Show Packages'),
            ),
          ),
        ],
      ),
    );
  }
}
