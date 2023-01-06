import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductProvider with ChangeNotifier {
  int value = 1;
  String? categoryName;
  List imagelist = [];
  List<String> imageUrls = [];
  List<XFile> file = [];
  List getAllProductList = [];

  Future getImage(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickMultiImage();

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

    imagelist.addAll(file);
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
}
