import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_background_remover/Provider/image_provider.dart';
import 'package:provider/provider.dart';

class ImageConatiner extends StatelessWidget {
  final VoidCallback onpress;
  final File? imag;
  const ImageConatiner({super.key, required this.onpress, this.imag});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderClass>(context);
    final File? imageFile = imageProvider.image;
    return Flexible(
        flex: 4,
        child: InkWell(
          onTap: () {
            onpress();
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(14)),
            child: AspectRatio(
              aspectRatio: 1,
              child: FittedBox(
                  child: imageFile != null
                      ? Image.file(
                          imageProvider.image!.absolute,
                        )
                      : const Icon(Icons.image)),
            ),
          ),
        ));
  }
}
