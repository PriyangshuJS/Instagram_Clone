import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

pickImage(ImageSource src) async {
  final ImagePicker _imgpicker = ImagePicker();
  XFile? files = await _imgpicker.pickImage(source: src);
  if (files != null) {
    return await files.readAsBytes();
  }
  print("No File Selected");
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}
