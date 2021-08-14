import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'entry_lists_screen.dart';
import 'package:wastetrack/models/food_waste_post.dart';

class NewPostScreen extends StatefulWidget {
  final imageFile;

  const NewPostScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  late TextEditingController _controller;
  bool _emptyField = false;
  final post = FoodWastePost();
  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '1');
    retrieveLocation();
    post.quantity = 1;
    post.latitude = 40.7541;
    post.longitude = -73.9850;
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Post'),
          leading: NewPostBackButton(),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Image.file(widget.imageFile),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: numberOfItemsTextField(),
            ),
          ]),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                child: Semantics(
                  child:  ElevatedButton(
                    child: Icon(Icons.cloud_upload_outlined),
                    onPressed: () {
                      if (!_emptyField) {
                        uploadData();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EntryListsScreen()),
                        );
                      }
                    },
                  ),
                  button: true,
                  enabled: true,
                  onTapHint: 'Upload a new Food Waste Post',
                ),
              )
            ],
          )
        ]);
  }

  Future getImageUrl() async {
    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(widget.imageFile);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  void uploadData() async {
    post.imageURL = await getImageUrl();
    post.date = Timestamp.now();
    FirebaseFirestore.instance.collection('posts').add({
      'date': post.date,
      'imageURL': post.imageURL,
      'quantity': post.quantity,
      'latitude': post.latitude,
      'longitude': post.longitude
    });
  }

  Widget numberOfItemsTextField() {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Number of items',
        errorText: _emptyField ? 'Enter a number' : null,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onTap: () {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.value.text.length,
        );
      },
      onChanged: (value) {
        setState(() {
          _controller.text.isEmpty ? _emptyField = true : _emptyField = false;
        });
      },
      onSubmitted: (value) {
        post.quantity = int.parse(value);
      },
    );
  }
}

class NewPostBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackButton(
        onPressed: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => EntryListsScreen())));
  }
}
