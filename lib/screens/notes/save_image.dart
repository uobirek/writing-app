import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> saveImageToLocalDirectory(File imageFile) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${imageFile.uri.pathSegments.last}';
    final savedImage = await imageFile.copy(imagePath);
    return savedImage.path;
  } catch (err) {
    throw Exception('Error saving image: $err');
  }
}
