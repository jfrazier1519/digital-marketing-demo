import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../shared/bottom_nav_bar.dart';
import '../shared/rounded_container.dart';
import '../../res/images.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _contentController = TextEditingController();
  String? _selectedImagePath;
  final String profileImageUrl = dummyProfileImage;
  final String userName = 'John Doe';

  _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // Open file explorer to select image

    setState(() {
      if (pickedFile != null) {
        _selectedImagePath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  _post() {
    // TODO: Implement logic to post the content
    String content = _contentController.text;
    String? imagePath = _selectedImagePath;

    // Post content using content and imagePath
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_selectedImagePath != null)
              Image.file(File(_selectedImagePath!)),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(profileImageUrl),
                  radius: 25,
                ),
                const SizedBox(width: 20),
                Text(
                  userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _post,
                  child: const Text('Post'),
                ),
              ],
            ),
            RoundedContainer(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: 'Write your post content...',
                  border: InputBorder.none,
                ),
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('Add Image'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
