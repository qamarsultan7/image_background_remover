import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_background_remover/Provider/image_provider.dart';
import 'package:image_background_remover/Resources/constants.dart';
import 'package:provider/provider.dart';

class ImageProcess {
  Future<void> removeBG(BuildContext context) async {
    final imgpr = Provider.of<ImageProviderClass>(context, listen: false);
    final File? img = imgpr.image;
    try {
      List<int> imageBytes = img?.readAsBytesSync() as List<int>;
      String base64Image = base64Encode(imageBytes);
      final response = await http.post(Uri.parse(APIURL),
          headers: {'X-API-Key': APIKEY, 'Content-Type': 'application/json'},
          body: jsonEncode({'image_file_b64': base64Image, 'size': 'auto'}));
      if (response.statusCode == 200) {
        imgpr.setSpiner(false);
        print('Removed Successful');
        imgpr.setProceedImage(response.bodyBytes);
      } else {
        imgpr.setSpiner(false);
        print('Error${response.statusCode}');
      }
    } catch (e) {
      imgpr.setSpiner(false);
      print('Error here $e');
    }
  }
}
