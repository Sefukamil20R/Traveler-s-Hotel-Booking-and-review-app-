import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageStorage {
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image and return its path
  Future<String?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final String imagePath = pickedFile.path;
      return imagePath;
    }
    return null;
  }
}
