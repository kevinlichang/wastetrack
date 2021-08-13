import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wastetrack/widgets/add_new_post_button.dart';

class EntryListsScreen extends StatefulWidget {
  @override
  _EntryListsScreenState createState() => _EntryListsScreenState();
}

class _EntryListsScreenState extends State<EntryListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WasteTrack')),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(DateFormat.yMMMEd().format(post['date'].toDate())),
                      trailing: Text(post['num_of_items'].toString()),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: AddNewPostButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/*
class NewEntryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // FirebaseFirestore.instance
          //     .collection('posts')
          //     .add({'name': 'Cupcake', 'num_of_items': 22});
        });
  }
}
*/