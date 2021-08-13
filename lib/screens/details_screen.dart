import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wastetrack/app.dart';
import 'package:wastetrack/models/food_waste_post.dart';

class DetailsScreen extends StatelessWidget {
  final FoodWastePost post;

  const DetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat.yMMMMEEEEd().format(post.date!.toDate())),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Image.network(post.imageURL!),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '${post.quantity} items',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Location: (${post.latitude}, ${post.longitude})',
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
