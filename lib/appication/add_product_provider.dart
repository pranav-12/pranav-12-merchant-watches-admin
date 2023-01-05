import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductProvider with ChangeNotifier {
  int value = 1;
  List imagelist = [];
  String? categoryName;
  String? imageUrl;

  Future getImage(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    print('==================================');

    if (file == null) {
      return;
    }
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImages = reference.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      log(error.toString());
      print('----------------------------------$error');
    }
    // log(image.toString());

    // if (image.length > 4 || imagelist.length > 4) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Only 4 Images can add'),
    //     ),
    //   );
    //   return;
    // } else if (imagelist.length + image.length > 4) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Only ${4 - imagelist.length} more Images can add'),
    //   ));
    //   return;
    // }
    // imagelist.addAll(image);
    imagelist.add(file);

    notifyListeners();
  }

  void deleteImageList(int index) {
    imagelist.removeAt(index);
    notifyListeners();
  }

  void changeCategoryName(String newName) {
    categoryName = newName;
    notifyListeners();
  }

  void changeValue(int newValue) {
    value = newValue;
    notifyListeners();
  }

  // MediaType() {}
}
