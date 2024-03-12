import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Image_uploads extends StatefulWidget {
  const Image_uploads({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<Image_uploads> createState() => _Image_uploadsState();
}

class _Image_uploadsState extends State<Image_uploads> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            "Add Profile image",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        )
      ],
    );
  }
}
