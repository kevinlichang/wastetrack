import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastetrack/screens/new_post_screen.dart';

class AddNewPostButton extends StatelessWidget {
  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    final imageFile = File(pickedFile!.path);
    return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        final image = await getImage();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPostScreen(imageFile: image),
          ),
        );
      },
    );
  }
}
