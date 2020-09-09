import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/ambience/providers.dart';
import 'package:olx_clone/code/models/user.dart';
import 'package:olx_clone/code/services/repository.dart';
import 'package:olx_clone/code/states/location_state.dart';
import 'package:olx_clone/code/states/sell_state.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/location.dart';
import 'package:olx_clone/ui/routes/profile.dart';
import 'package:olx_clone/ui/widgets/user_account_tile.dart';

// how to upload multiple files to firebase storage
// 1) select all desired images throgh multiImagePicker plugin
// 2) store selected images in memory
// 3) make a copy of the selected images in device Temporary directory
// 4) now get these copied images and upload them to firebase storage
// 5) delete every copied image from temporary directory

class Sell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final sellState = watch(sellStateProvider);

        return Scaffold(
          body: PageView(
            // physics: NeverScrollableScrollPhysics(),
            controller: sellState.pagesController,
            children: [
              FormPage(),
              ImagesPickerPage(),
              SetPrice(),
              ConfirmYourLocationPage(),
              Location(title: 'Confirm your location'),
              ReviewAdDetailsPage(),
            ],
          ),
          bottomNavigationBar: Material(
            elevation: 100,
            child: MaterialButton(
              onPressed: () {
                print('going to next page');
                // sellStateProvider.read(context).pagesController.nextPage(
                //       duration: Duration(milliseconds: 200),
                //       curve: Curves.bounceIn,
                //     );
                // if (state.pagesController.page < 3.0) {
                if (sellState.pagesController.page != 3) {
                  sellState.pagesController.nextPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.bounceIn,
                  );
                }
                // }
                if (sellState.pagesController.page == 5.0) {
                  if (sellState.images.isNotEmpty) {
                    // uploadFiles(images);
                    sellState.storeImagesInTempDir(sellState.images);
                  }

                  sellState.setAd();

                  firestore
                      .collection('ads')
                      .doc()
                      .set(sellState.ad?.toDocument());
                  // goto the review ad page
                  // goto();
                }
              },
              color: Colors.teal[900],
              minWidth: double.infinity,
              height: 50,
              // child: sellState.pagesController.page == 5
              child: 1 == 5 ? Text('Post Ad') : Text('Next'),
            ),
          ),
        );
      },
    );
  }
}

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final SellState state = sellStateProvider.
    // final count = useProvider(myNotifierProvider);

    return Consumer(builder: (context, read, child) {
      final state = read(sellStateProvider);

      var size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
          title: Text('Include some details'),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Form(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        child: FutureBuilder<QuerySnapshot>(
                          future: firestore
                              .collection('categories')
                              .where('name', isEqualTo: 'Mobiles')
                              .get(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Text('waiting...');
                            } else {
                              return TextField(
                                controller: state.makerSelectorController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Maker *',
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        // title: Text('Customer Type'),
                                        actions: [
                                          for (var maker in snapshot
                                              .data.docs[0]
                                              .data()['maker'])
                                            MaterialButton(
                                              onPressed: () {
                                                state.selectedMaker = maker;
                                                state.makerSelectorController
                                                    .text = state.selectedMaker;
                                                pop(context);
                                                // state.ad.maker
                                              },
                                              child: Text(maker),
                                            ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Condtion *'),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (String condition in state.conditions)
                          OutlineButton(
                            textColor: state.selectedCondition == condition
                                ? Colors.green
                                : Colors.teal[900],
                            onPressed: () {
                              // sellStateProvider.read(context).selectedCondition =
                              //     condition;
                              state.selectedCondition = condition;
                            },
                            child: Text(condition),
                          ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        // autofillHints: ,
                        onChanged: (input) {
                          state.adTitle = input;
                        },
                        // validator: (input) {
                        //   if (input.isNotEmpty) return null;

                        //   return 'Please insert a valid email';
                        // },
                        decoration: InputDecoration(labelText: 'Ad Title *'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        // autofillHints: ,
                        onChanged: (input) {
                          state.description = input;
                        },
                        // validator: (input) {
                        //   if (input.isNotEmpty) return null;

                        //   return 'Please insert a valid email';
                        // },
                        decoration: InputDecoration(
                            labelText: 'Describe what are you selling *'),
                      ),
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class ImagesPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Images of the product'),
      ),
      body: Consumer(builder: (context, read, child) {
        var sellState = read(sellStateProvider);
        return Column(
          children: <Widget>[
            if (sellState.images.isNotEmpty)
              SizedBox(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo,
                          size: 46,
                        ),
                        Icon(
                          Icons.broken_image,
                          size: 76,
                        ),
                        Icon(
                          Icons.g_translate,
                          size: 50,
                        ),
                      ],
                    ),
                    Text(
                      'Uploading more photos increases your \n chance of closing a deal',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            if (sellState.images.isEmpty)
              Expanded(
                child: InkWell(
                  onTap: sellState.loadAssets,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.add_a_photo),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text('Tap to Select Images'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (sellState.images.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  itemCount: sellState.images.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, position) {
                    if (position < sellState.images.length) {
                      print(sellState.images[position]);
                      return AssetThumb(
                        // asset: asset,
                        asset: sellState.images[position],
                        width: 300,
                        height: 300,
                      );
                    } else {
                      if (sellState.images.length < 12)
                        return FlatButton(
                          color: Colors.red,
                          onPressed: sellState.loadAssets,
                          child: Icon(Icons.add),
                        );
                    }
                    return null;
                  },
                ),
              ),
            // MaterialButton(
            //   onPressed: () {
            //     if (sellState.images.isNotEmpty) {
            //       // uploadFiles(images);
            //       sellState.storeImagesInTempDir(sellState.images);
            //     }
            //   },
            //   child: Text('upload images'),
            // ),
          ],
        );
      }),
    );
  }
}

class SetPrice extends StatelessWidget {
  final String title = 'Set a price';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price'),
      ),
      body: Consumer(
        builder: (context, read, cild) {
          final state = read(sellStateProvider);

          return Padding(
            padding: const EdgeInsets.all(18),
            child: TextFormField(
              // autofillHints: ,
              onChanged: (input) {
                state.price = input;
              },
              // validator: (input) {
              //   if (input.isNotEmpty) return null;

              //   return 'Please insert a valid email';
              // },
              decoration: InputDecoration(
                labelText: 'Price',
                prefix: Text('Rs | '),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ConfirmYourLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm your location'),
      ),
      body: ListView(
        children: [
          Consumer(
            builder: (context, watch, child) {
              LocationState locationState = watch(locationStateProvider);
              return ListTile(
                title: Text('Location'),
                subtitle: Text(
                  locationState.currentAddress?.addressLine ??
                      'Tap to choose an address',
                ),
                // onTap: goto(context, Location(title: 'Location')),
                onTap: () {
                  context.read(sellStateProvider).pagesController.nextPage(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceIn,
                      );
                },
              );
            },
          ),
          // Text('wo'),
        ],
      ),
    );
  }
}

class ReviewAdDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review your details')),
      body: FutureBuilder<UserDoc>(
          future: Repository().getUser(auth.currentUser.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            UserDoc user = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  UserAccountTile(
                    onPress: () => Profile(user),
                    user: user,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Verifiied phone number'),
                      // Spacer(),
                      Row(
                        children: [
                          Icon(Icons.check_box),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              user.phoneNumber,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Show my phone number on my ads'),
                      Switch(value: true, onChanged: (state) {}),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
