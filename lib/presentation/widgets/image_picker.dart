import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

import 'buttons/solid_button.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? pickedImage;

  Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        setState(() {
          pickedImage = File(image.path);
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (pickedImage != null)
          Image.file(
            pickedImage!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )
        else
          Container(),
        Padding(
          padding: const EdgeInsets.only(top: Dimens.standardPadding),
          child: Container(
            child: SolidButton(
              label: "Ajouter une image",
              backgroundColor: Theme.of(context).customColors.primary,
              onPressed: () => pickImage(),
              icon: const Icon(Icons.add_photo_alternate_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
