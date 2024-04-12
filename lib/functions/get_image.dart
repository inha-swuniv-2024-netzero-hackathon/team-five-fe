import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<List<File>> getImages() async {
  final picker = ImagePicker();
  List<File> selectedImages = [];
  final pickedFile = await picker.pickMultiImage(
      imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
  List<XFile> xfilePick = pickedFile;

  if (xfilePick.isNotEmpty) {
    for (var i = 0; i < xfilePick.length; i++) {
      selectedImages.add(File(xfilePick[i].path));
    }
  }
  return selectedImages;
}

Future<File?> getImage() async {
  final picker = ImagePicker();
  File? image;
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    image = File(pickedFile.path);
  }
  return image;
}
