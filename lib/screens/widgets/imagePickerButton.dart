// lib/screens/widgets/image_picker_button.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  final void Function(File?) onImagePicked;

  const ImagePickerButton({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      widget.onImagePicked(_selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('동아리 이미지 선택'),
        ),
        const SizedBox(width: 16),
        _selectedImage != null
            ? Image.file(
                _selectedImage!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              )
            : const Text('선택된 이미지 없음'),
      ],
    );
  }
}