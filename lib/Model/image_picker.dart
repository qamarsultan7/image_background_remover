import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_background_remover/Provider/image_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyImagePicker {
 
  final ImagePicker _imagePicker = ImagePicker();
  Future<void> chooseImage(BuildContext context) async {
     final  imgprovider = Provider.of<ImageProviderClass>(context,listen: false);
    File? imagefile;
    try {
      const permission=true;
      if (permission) {
      final pickedfile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedfile != null) {
        imagefile=File(pickedfile.path);
        imgprovider.setImage(imagefile);
      }
    }
    } catch (e) {
      print('Error $e');
    }
  }
}
