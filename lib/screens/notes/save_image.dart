import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> saveImageToLocalDirectory(File imageFile) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    print('App Directory: ${directory.path}');
    final imagePath = '${directory.path}/${imageFile.uri.pathSegments.last}';
    print('Image Path: $imagePath');
    final savedImage = await imageFile.copy(imagePath);
    print('Saved Image Path: ${savedImage.path}');
    return savedImage.path;
  } catch (e) {
    print('Error saving image: $e');
    throw Exception('Error saving image: $e');
  }
}
