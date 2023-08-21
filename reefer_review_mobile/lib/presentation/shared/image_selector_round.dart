import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({
    super.key,
    required this.onSubmit,
    this.radius = 50,
  });

  final double radius;

  final Function(String? image) onSubmit;

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  String? _selectedImagePath;

  @override
  Widget build(BuildContext context) {
    final iconSize = widget.radius * 0.65;
    return GestureDetector(
      onTap: _selectImage,
      child: CircleAvatar(
        radius: widget.radius / 2,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundImage:
            _selectedImagePath != null ? AssetImage(_selectedImagePath!) : null,
        child: _selectedImagePath == null
            ? _buildPlaceHolderStack(iconSize)
            : Icon(
                Icons.photo_camera,
                color: Colors.white10.withOpacity(0.75),
                size: widget.radius * 0.65,
              ),
      ),
    );
  }

  _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImagePath = pickedFile.path;
        widget.onSubmit(_selectedImagePath);
      } else {
        if (kDebugMode) {
          print("No image selected");
        }
      }
    });
  }

  _buildPlaceHolderStack(double iconSize) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.person,
            size: iconSize * 1.5, color: Theme.of(context).colorScheme.primary),
        Icon(
          Icons.photo_camera,
          color: Colors.white.withOpacity(0.45),
          size: iconSize,
        ),
      ],
    );
  }
}
