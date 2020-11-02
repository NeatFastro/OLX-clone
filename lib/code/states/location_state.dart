import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart' as geoCoder;
import 'package:location/location.dart';

import 'package:geocoder/model.dart';
import 'package:http/http.dart' as http;
import 'package:olx_clone/code/ambience/api_keys.dart';
import 'package:uuid/uuid.dart';

class LocationState extends ChangeNotifier {
  Address currentAddress;
  List<Address> recentlyUsedAddresses = [];
  String query = '';
  List searchSuggestions = [];
  bool isGpsEnabled;
  bool loading = false;
  Location location = Location();
  GeoPoint _currentGeoPoint;
  // var suggestions;
  // GeoPoint adUploadLocation = GeoPoint

  get currentGeoPoint => _currentGeoPoint ?? GeoPoint(30.3753, 69.3451);

  Future<void> getCurrentLocation() async {
    if (await location.serviceEnabled()) {
      location.getLocation().then((data) async {
        final coordinates = Coordinates(data.latitude, data.longitude);
        _currentGeoPoint = GeoPoint(data.latitude, data.longitude);

        geoCoder.Geocoder.local
            .findAddressesFromCoordinates(coordinates)
            .then((addresses) {
          currentAddress = addresses[0];

          if (!recentlyUsedAddresses.contains(currentAddress)) {
            recentlyUsedAddresses.add(currentAddress);
          }
          notifyListeners();
        });
      });
      return;
    } else {
      await location.requestService();
      // if (await location.serviceEnabled()) {
      getCurrentLocation();
      int counter = 0;
      print('recursion kicked in ${counter++}');
      notifyListeners();
      // }
    }
  }

  setCurrentAddress2(Address address) {
    currentAddress = address;
    notifyListeners();
  }

  void setCurrentAddress(String value) {
    // Geocoder.local.findAddressesFromCoordinates(coordinates)
    currentAddress = Address(
      addressLine: value,
    );
    searchSuggestions.clear();
    recentlyUsedAddresses.add(currentAddress);
    print('notifying listeners');

    notifyListeners();

    // caching for reccent address
    // if (!recentAddresses.any((address) {
    //   return address.addressLine != currentAddress.addressLine;
    // })) {
    //   recentAddresses.add(currentAddress);
    // }

    // print('current address');
    // print(currentAddress.addressLine);
    // recentAddresses.add(currentAddress);
    // print('recent addresses');
    // recentAddresses.forEach((element) => print(element.addressLine));

    // recentAddresses.forEach((ra) {
    //   if (ra.addressLine != currentAddress.addressLine) {
    //     recentAddresses.add(currentAddress);
    //   }
    // });
    // if (!recentAddresses.contains(currentAddress)) {
    //   recentAddresses.add(currentAddress);
    // }

    // Geocoder.google(
    //   googlePlaycesApiKey,
    // ).findAddressesFromQuery(value).then((addresses) {
    //   currentAddress = addresses[0];
    //   notifyListeners();
    // }).catchError((err) {
    //   print(err);
    // });
  }

  autoCompleteSearch(String query) async {
    print('auto complete is running');

    // if (query.length > 2) {
    var uri = Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      path: '/maps/api/place/autocomplete/json',
      queryParameters: {
        'input': query,
        'types': 'geocode',
        'components': 'country:PK',
        'sessiontoken': Uuid().v4(),    
        'key': googlePlaycesApiKey,
      },
    );
    print('uri is $uri');
    http.Response response = await http.get(uri);
    List jsons = jsonDecode(response.body)['predictions'];
    searchSuggestions.clear();
    searchSuggestions.addAll(jsons);
    print('fresh suggestions are: $jsons');
    notifyListeners();
    // } else {
    if (query.isEmpty) {
      searchSuggestions.clear();
      notifyListeners();
    }
    // }
  }
}
