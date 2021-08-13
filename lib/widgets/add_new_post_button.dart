import 'package:flutter/material.dart';
import 'package:wastetrack/screens/add_post.dart';

class AddNewPostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddPostScreen()),
      ),
    );
  }
}
