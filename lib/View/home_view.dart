import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_background_remover/Model/image_picker.dart';
import 'package:image_background_remover/Model/image_processor.dart';
import 'package:image_background_remover/Model/save_image.dart';
import 'package:image_background_remover/Provider/image_provider.dart';
import 'package:image_background_remover/Resources/Widgets/buttons.dart';
import 'package:image_background_remover/Resources/Widgets/image_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Imagpr = Provider.of<ImageProviderClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Background Remover',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<ImageProviderClass>(
          builder: (_, value, __) => Column(
            children: [
              ImageConatiner(
                onpress: () {
                  MyImagePicker().chooseImage(context);
                },
              ),
              buttons(context, () async {
                Imagpr.setSpiner(true);
                ImageProcess().removeBG(context);
              },
                  value.spinner == true
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Remove BackGround',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
              Flexible(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(14)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FittedBox(
                      child: value.proceedImage != null
                          ? Image.file(Imagpr.proceedImage!.absolute)
                          : const Icon(Icons.image),
                    ),
                  ),
                ),
              ),
              buttons(context, () async {
                Imagpr.setsaveSpiner(true);
                final res = SaveImage().saveImage(context);

                Future.value(res).then((value) {
                  SnackBar snackBar = const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(20),
                    content: Center(
                      child: Text(
                        'Image Saved',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    duration: Duration(milliseconds: 1200),
                    backgroundColor: Color(0xff0ead69),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
                  Imagpr.saveSpninner == true
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Save To Gallery',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
