import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastetrack/models/food_waste_post.dart';

void main() {
  test('Post created from Map should have appropriate values', () {
    final date = Timestamp.now();
    const url = "FAKE";
    const quantity = 7;
    const latitude = 11.0;
    const longitude = 22.0;

    final FoodWastePost testPost = FoodWastePost();
    testPost.fromMap({
      'date': date,
      'imageURL': url,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    expect(testPost.date, date);
    expect(testPost.imageURL, url);
    expect(testPost.quantity, quantity);
    expect(testPost.latitude, latitude);
    expect(testPost.longitude, longitude);
  });

  test('convertDatetoDateTime should convert Timestamp to Datetime', () {
    final date = Timestamp.now();
    const url = "FAKE";
    const quantity = 7;
    const latitude = 11.0;
    const longitude = 22.0;

    final FoodWastePost testPost = FoodWastePost(
      date: date,
      imageURL: url,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude,
    );

    expect(testPost.convertDatetoDateTime(), date.toDate());
  });

  test('get coordinates from latitude and longitude', () {
    final date = Timestamp.now();
    const url = "FAKE";
    const quantity = 7;
    const latitude = 11.0;
    const longitude = 22.0;

    final FoodWastePost testPost = FoodWastePost(
      date: date,
      imageURL: url,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude,
    );

    String coordinates = '($latitude, $longitude)';

    expect(testPost.getCoordinates(), coordinates);
  });
}
