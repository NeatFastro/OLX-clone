import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoder/geocoder.dart';
import 'package:olx_clone/code/ambience/providers.dart';

class Location extends StatefulWidget {
  final String title;

  const Location({Key key, this.title = 'Location'}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer(
        builder: (context, read, child) {
          final locationState = read(locationStateProvider);

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (input) {
                        // print('auto complete is running');

                    locationState.autoCompleteSearch(input);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search city, area or neighbourhood',
                    suffixIcon: locationState.query.isNotEmpty
                        ? IconButton(icon: Icon(Icons.close), onPressed: () {})
                        : null,
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
              ),
              // show only the searched results and remove everything else
              // build suggestions
              if (locationState.searchSuggestions.isNotEmpty) ...[
                for (var result in locationState.searchSuggestions)
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: Text(result['description']),
                      trailing: Icon(Icons.arrow_upward),
                      onTap: () => locationState
                          .setCurrentAddress(result['description']),
                    ),
                  ),
              ],
              // remove this section if there are any search results predictions or autocompletes
              if (locationState.searchSuggestions.isEmpty) ...[
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
                  for (Address address in locationState.recentlyUsedAddresses)
                    ListTile(
                      leading: Icon(Icons.pin_drop),
                      title: Text(address.featureName ?? 'null'),
                      subtitle: Text(address.addressLine),
                      onTap: () => locationState.setCurrentAddress2(address),
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
          );
        },
      ),
    );
  }
}
