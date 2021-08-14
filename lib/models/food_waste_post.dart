import 'package:cloud_firestore/cloud_firestore.dart';

class FoodWastePost {
  Timestamp? date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;

  FoodWastePost(
      {this.date, this.imageURL, this.quantity, this.latitude, this.longitude});

  String toString() {
    return 'date: $date, imageURL:$imageURL, quantity: $quantity, latitude: $latitude, longitude: $longitude';
  }

  void fromMap(Map map) {
    date = map['date'];
    imageURL = map['imageURL'];
    quantity = map['quantity'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  DateTime convertDatetoDateTime() {
    return date!.toDate();
  }

  String getCoordinates() {
    return '($latitude, $longitude)';
  }
}
