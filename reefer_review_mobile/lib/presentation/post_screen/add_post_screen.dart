import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../res/routes.dart';
import '../../data/post/general_post.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    super.key,
  });

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _contentController = TextEditingController();
  String? _selectedImagePath;

  _selectImage() async {
    // TODO: Implement logic to select an image
    setState(() {
      _selectedImagePath = 'path/to/your/image.jpg';
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
            if (_selectedImagePath != null) Image.network(_selectedImagePath!),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Write your post content...',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('Add Image'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _post,
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
