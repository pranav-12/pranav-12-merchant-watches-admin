import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductProvider with ChangeNotifier {
  int value = 1;
  List imagelist = [];
  String? categoryName;
  List imageUrls = [];

  Future getImage(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    List<XFile> file = await imagePicker.pickMultiImage();

    if (file.length > 4 || imagelist.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only 4 Images can add'),
        ),
      );
      return;
    } else if (imagelist.length + file.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Only ${4 - imagelist.length} more Images can add'),
      ));
      return;
    }
    try {
      for (var elemt in file) {
        Reference reference =
            FirebaseStorage.instance.ref().child('images/${elemt.name}');
        await reference.putFile(File(elemt.path));
        String img = await reference.getDownloadURL();
        log(img);
        imageUrls.add(img);

        imagelist.add(elemt);
        notifyListeners();
      }

      log("----------imageUrls : " + imageUrls.toString());
    } catch (error) {
      log(error.toString());
      print('----------------------------------$error');
    }
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

}
