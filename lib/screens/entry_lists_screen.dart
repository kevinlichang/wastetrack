import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wastetrack/widgets/add_new_post_button.dart';
import 'details_screen.dart';
import 'package:wastetrack/models/food_waste_post.dart';

class EntryListsScreen extends StatefulWidget {
  @override
  _EntryListsScreenState createState() => _EntryListsScreenState();
}

class _EntryListsScreenState extends State<EntryListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WasteTrack'),
        leading: Container(),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var postData = snapshot.data!.docs[index];
                  var post = FoodWastePost(
                    date: postData['date'],
                    imageURL: postData['imageURL'],
                    quantity: postData['quantity'],
                    latitude: postData['latitude'],
                    longitude: postData['longitude'],
                  );

                  return ListTile(
                    title: Text(
                      DateFormat.yMMMEd().format(post.date!.toDate()),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: Text(post.quantity.toString(), style: Theme.of(context).textTheme.headline4),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          post: post,
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        child: AddNewPostButton(),
        button: true,
        enabled: true,
        onTapHint: 'Select an image from gallery for a new post',
      )
      
      
    );
  }
}
