import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoder/model.dart';
import 'package:olx_clone/code/ambience/providers.dart';
import 'package:olx_clone/code/utils.dart';

class Search extends SearchDelegate {
  List popularCategories = ['Mobiles', 'Vehicles', 'Property for Sale'];
  bool isSearching = true;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            context.read(exploreStateProvider).changeSearcTerm(query);
            pop(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // throw UnimplementedError();
    if (query.isEmpty) {
      return ListView(
        children: [
          Consumer(builder: (context, provider, child) {
            var locationState = provider(locationStateProvider);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (input) {
                        locationState.autoCompleteSearch(input);
                      },
                      onTap: () {
                        isSearching = false;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.location_on_outlined),
                        hintText: 'Search city, area or neighbourhood',
                        suffixIcon: locationState.query.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.close), onPressed: () {})
                            : null,
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                    ),
                  ),
                  if (locationState.searchSuggestions.isEmpty &&
                      isSearching == false) ...[
                    ListTile(
                      leading: Icon(Icons.gps_fixed),
                      title: Text('Use current location'),
                      subtitle: Text(
                        locationState.currentAddress?.addressLine == null
                            ? 'Enable Location'
                            : locationState.currentAddress.addressLine,
                      ),
                      onTap: locationState.getCurrentLocation,
                    ),
                    // only build/show the RECENTLY USED section if there are any recently used addresses
                    if (locationState.recentlyUsedAddresses.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: SizedBox(
                          width: double.infinity,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text('RECENTLY USED'),
                            ),
                          ),
                        ),
                      ),
                      for (Address address
                          in locationState.recentlyUsedAddresses)
                        ListTile(
                          leading: Icon(Icons.pin_drop),
                          title: Text(address.featureName ?? 'null'),
                          subtitle: Text(address.addressLine),
                          onTap: () {
                            locationState.setCurrentAddress2(address);
                            isSearching = true;
                            print('searching is true again');
                          },
                        ),
                    ],

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: SizedBox(
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text('CHOOSE STATE'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
          if (isSearching == true)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Popular Categories'),
            ),
          if (isSearching == true)
            for (String category in popularCategories)
              ListTile(
                leading: Icon(Icons.search),
                title: Text(category),
              )
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
