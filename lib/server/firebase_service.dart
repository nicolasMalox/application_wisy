
import 'dart:io';
import 'dart:math';

import 'package:application_wisy/models/photo_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  //
  // A reference to Firebase Storage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // A reference to Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get a list of photos from the server
  Future<List<Photo>> getPhotosFromServer() async {
    // Get a reference to the photos collection
    CollectionReference photosReference = _firestore.collection('photos');

    // Get all of the documents in the collection
    final snapshot = await photosReference.get();

    // Convert the documents to Photo objects
    final photos = snapshot.docs.map((photoDoc) {
      final data = photoDoc.data() as Map<String, dynamic>;
      return Photo(url: data['url'] ?? '', timestamp: data['timestamp'] ?? '');
    }).toList();

    return photos;
  }

  // Upload a photo to the server
  Future<bool> uploadPhotoToServer(
      {required File photo, required Timestamp time}) async {
    // Generate a random filename for the photo
    final String fileName = generateRandomString();

    // Create a Reference object to the file in Firebase Storage
    final Reference ref = _storage.ref().child("images").child(fileName);

    // Upload the photo to Firebase Storage
    final UploadTask uploadTask = ref.putFile(photo);

    // Get the download URL for the photo
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    final String url = await snapshot.ref.getDownloadURL();

    // Add a document to the photos collection in Firebase Firestore
    await _firestore.collection('photos').add({'url': url, 'timestamp': time});

    return snapshot.state == TaskState.success;
  }

  // Generate a random string of 5 characters
  String generateRandomString() {
    // Create a list of characters
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';

    // Create a Random object
    final random = Random();

    // Create a StringBuffer object to build the random string
    final result = StringBuffer();

    for (var i = 0; i < 5; i++) {
      final index = random.nextInt(characters.length);
      result.write(characters[index]);
    }

    return result.toString();
  }
}
