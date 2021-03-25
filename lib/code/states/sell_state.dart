import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/ad.dart';
import 'package:olx_clone/code/states/location_state.dart';
import 'package:uuid/uuid.dart';

class SellState extends ChangeNotifier {
  bool canUpload = false;

  SellState() {
    setMakers();
  }

  Ad _ad;

  // PageController pagesController = PageController();
  PageController pagesController;
  List<String> pages = ['form', 'uploadPicstures', 'setPrice', 'setLocation'];
  List<String> makers = ['sony, samsung, apple, lg, google'];
  List conditions = ['New', 'used'];
  List<String> downloadUrls = [];
  List<Asset> images = List<Asset>();

  TextEditingController makerSelectorController =
      TextEditingController(text: '');

  String adTitle;
  String description;
  String selectedMaker;
  String _selectedCondition = '';
  String price;
  String category;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  get selectedCondition => _selectedCondition;

  set selectedCondition(String value) {
    _selectedCondition = value;
    notifyListeners();
  }

  Future<void> setAd(images) async {
    if (this.images.isNotEmpty) {
      storeImagesInTempDir(images).then((value) {
        User user = auth.currentUser;

        _ad = Ad(
          adId: Uuid().v1(),
          maker: this.selectedMaker,
          title: adTitle,
          description: description,
          price: price,
          condition: selectedCondition,
          images: downloadUrls,
          postedAt: DateTime.now().toIso8601String(),
          postedBy: user.uid,
          adUploadLocation: LocationState().currentGeoPoint,
        );

        pagesController.dispose();

        adTitle = '';
        description = '';
        price = '';
        selectedCondition = '';
        downloadUrls.clear();

        canUpload = true;
      });
    } else {
      print('no image is selected');
    }
  }

  Ad get ad => _ad;

  setMakers() {
    firestore
        .collection('categories')
        .where('name', isEqualTo: 'Mobiles')
        .get()
        .then((value) {
      // makers.addAll(value.docs[0].data['makers']);
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 12,
        enableCamera: true,
        selectedAssets: images,
        // cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#aaaccc",
          lightStatusBar: false,
          actionBarTitle: "Gallery",
          allViewTitle: "All Photos",
          useDetailsView: false,
          // startInAllView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } catch (e) {
      // error = e.toString();
      print('error loading assets');
      print(e);
    }

    images = resultList;

    notifyListeners();
  }

  Future<void> uploadImageToStorage(
      String imageName, File imagefile, User user) async {
    // StorageMetaData metaData = StorageMetaData();

    StorageUploadTask uploadedImage = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child(auth.currentUser.displayName + ' (${auth.currentUser.email})')
        .child(imageName)
        .putFile(imagefile);
    // .onComplete;

    // String uploadedImageUrl = await uploadedImage.ref.getDownloadURL();
    StorageTaskSnapshot storageTaskSnapshot = await uploadedImage.onComplete;
    var uploadedImageUrl = storageTaskSnapshot.ref.getDownloadURL();

    print('image url is $uploadedImageUrl');

    downloadUrls.add(uploadedImageUrl.toString());
  }

  // Timer.periodic(Duration(seconds: 1), (timer) { });

  printUrl() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(downloadUrls);
    });
  }

  Future<void> storeImagesInTempDir(List<Asset> images) async {
    final Directory tempDir = Directory.systemTemp;
    // final FirebaseUser user = await auth.currentUser();

    print('temp dir is : ${tempDir.path}');

    images.forEach((image) async {
      ByteData imageByteData = await image.getByteData();

      var imageFile =
          await File('${tempDir.path}/${DateTime.now()}.png').writeAsBytes(
        imageByteData.buffer.asUint8List(),
        mode: FileMode.write,
      );

      String imageFileName;
      imageFileName =
          '${auth.currentUser.displayName} | ${auth.currentUser.email} ${DateTime.now()}.jpg';

      await uploadImageToStorage(imageFileName, imageFile, auth.currentUser);
      // auth.currentUser().then((user) async {
      //   imageFileName =
      //       '${user.displayName} | ${user.email} ${DateTime.now()}.jpg';
      //   print('image file is $imageFile');
      await imageFile.delete();
      //   // print('deleted the image file');
      // });
      // });
      // });
    });
  }
}
