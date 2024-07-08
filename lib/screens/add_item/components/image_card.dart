import 'dart:io';

import 'package:black_box/screens/add_item/components/image_source_select_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCard extends StatelessWidget {
  final XFile? image;
  final void Function(XFile) onImageChanged;

  const ImageCard({
    super.key,
    this.image,
    required this.onImageChanged,
  });

  bool get imageExists => image != null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: TextButton(
        onPressed: () => _handleAddImage(context),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: _buttonChild(),
      ),
    );
  }

  Widget _buttonChild() {
    if (imageExists) {
      return Image.file(
        File(image!.path),
        fit: BoxFit.cover,
      );
    }

    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_a_photo),
        SizedBox(width: 10),
        Text('Add Image'),
      ],
    );
  }

  Future<void> _handleAddImage(BuildContext context) async {
    ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => const ImageSourceSelectSheet(),
    );

    if (source == null) return;

    XFile? image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      onImageChanged(image);
    }
  }
}
