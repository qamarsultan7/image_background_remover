import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_background_remover/Provider/image_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SaveImage {
  Future<void> saveImage(BuildContext context) async {
    final imgPr = Provider.of<ImageProviderClass>(context, listen: false);
    String fileNme =
        'removebg_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}.png';

    if (await _permissionGrant(Permission.manageExternalStorage,context)) {
      try {
        Directory? external = await getExternalStorageDirectory();

        if (external != null) {
          Directory dir = Directory('/storage/emulated/0/Flutter');

          if (!await dir.exists()) {
            dir.create(recursive: true);
          }
          if (await dir.exists()) {
            File file = File('${dir.path}/$fileNme');
            await file.writeAsBytes(imgPr.proceedImage!.readAsBytesSync()).then((value) {
              imgPr.setsaveSpiner(false);
              print('Image saved at: ${file.path}');
            });
          }
        } else {
          imgPr.setsaveSpiner(false);
          print('External storage directory not available.');
        }
      } catch (e) {
        imgPr.setsaveSpiner(false);
        print('Error Here $e');
      }
    }
  }
  Future<bool> _permissionGrant(Permission permission,BuildContext context) async {
     final imgPr = Provider.of<ImageProviderClass>(context, listen: false);
    if (await permission.isGranted) {
      imgPr.setsaveSpiner(false);
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        imgPr.setsaveSpiner(false);
        return true;
      } else if (result == PermissionStatus.denied) {
        imgPr.setsaveSpiner(false);
        await openAppSettings();
        return false;
      }
    }
    return false;
  }
}
