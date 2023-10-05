import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  final String url;
  final Timestamp timestamp;

  Photo({required this.url, required this.timestamp});
}
