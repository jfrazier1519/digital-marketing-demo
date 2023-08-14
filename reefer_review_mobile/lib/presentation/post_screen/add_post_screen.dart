import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../shared/bottom_nav_bar.dart';
import '../shared/rounded_container.dart';
import '../../res/images.dart';
import '../../data/post/general_post.dart';
import '../../data/models/user.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';

class AddPostScreen extends StatefulWidget {
  final FeedBloc feedBloc;
  final AuthBloc authBloc;

  const AddPostScreen(
      {required this.authBloc, required this.feedBloc, Key? key})
      : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _contentController = TextEditingController();
  String? _selectedImagePath;

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

    final currentState = widget.authBloc.state;
    if (currentState is AuthUserLoggedIn) {
      User user = currentState.user;

      GeneralPost post = GeneralPost(
        postId: DateTime.now().millisecondsSinceEpoch,
        author: user,
        date: DateTime.now(),
        content: content,
        image: _selectedImagePath ?? '',
      );

      widget.feedBloc.add(AddPost(post));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentState = widget.authBloc.state;
    String? userName;
    String? userProfileImageUrl;

    if (currentState is AuthUserLoggedIn) {
      userName = currentState.user.name;
      userProfileImageUrl = currentState.user.profileImageUrl;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
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
                    backgroundImage: AssetImage(userProfileImageUrl ?? ""),
                    radius: 25,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    userName ?? "",
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
