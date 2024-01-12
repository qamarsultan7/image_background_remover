import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageProviderClass with ChangeNotifier {
  File? _image;
  File? get image => _image;
  File? _proceedImage;
  File? get proceedImage => _proceedImage;
  bool _spninner = false;
  bool get spinner => _spninner;
  bool _saveSpninner = false;
  bool get saveSpninner => _saveSpninner;
  void setImage(File? img) {
    _image = img;
    notifyListeners();
  }

  void setProceedImage(List<int> bytesList) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/temp_image.png');
    await file.writeAsBytes(bytesList);
    _proceedImage = file;
    notifyListeners();
  }

  void setSpiner(bool spin) {
    _spninner = spin;
    notifyListeners();
  }

  void setsaveSpiner(bool spin) {
    _saveSpninner = spin;
    notifyListeners();
  }
}
