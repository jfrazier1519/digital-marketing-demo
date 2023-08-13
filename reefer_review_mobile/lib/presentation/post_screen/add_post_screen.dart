import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../shared/bottom_nav_bar.dart';
import '../shared/rounded_container.dart';
import '../../res/images.dart';
import '../../data/post/general_post.dart';
import '../../data/user.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';

class AddPostScreen extends StatefulWidget {
  final void Function() onClose;
  final FeedBloc feedBloc;

  const AddPostScreen({required this.onClose, required this.feedBloc, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _contentController = TextEditingController();
  String? _selectedImagePath;
  final String profileImageUrl = dummyProfileImage;
  final String userName = 'John Doe';

  _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImagePath = pickedFile.path;
      } else {
        if (kDebugMode) {
          print("No image selected");
        }
      }
    });
  }

  _post() {
    String content = _contentController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text before posting.')),
      );
      return;
    }

    GeneralPost post = GeneralPost(
      postId: DateTime.now().millisecondsSinceEpoch,
      author: User(
        userId: 'userID1',
        email: 'john.doe@example.com',
        name: 'John Doe',
        profileImageUrl: dummyProfileImage,
      ),
      date: DateTime.now(),
      content: content,
      image: _selectedImagePath ?? '',
    );

    widget.feedBloc.add(AddPost(post));
    widget.onClose();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onClose,
        ),
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_selectedImagePath != null)
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child:
                      Image.file(File(_selectedImagePath!), fit: BoxFit.cover),
                ),
              const SizedBox(height: 10),
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
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _post,
                    child: const Text('Post'),
                  ),
                ],
              ),
              RoundedContainer(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
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
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
