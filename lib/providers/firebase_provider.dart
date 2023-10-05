import 'dart:io';
import 'package:application_wisy/server/firebase_service.dart';
import 'package:application_wisy/models/photo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the list of photos
final photoListProvider = StateNotifierProvider<PhotoListNotifier, List<Photo>>(
  (ref) => PhotoListNotifier(),
);

// Notifier for managing the list of photos
class PhotoListNotifier extends StateNotifier<List<Photo>> {
  PhotoListNotifier() : super([]) {
    getPhotos();
  }

  Future<void> getPhotos() async {
    final firebaseService = FirebaseService();

    // Fetch photos from the server using FirebaseService
    final photos = await firebaseService.getPhotosFromServer();

    // Update the state with the fetched photos
    state = photos;
  }

  Future<bool> uploadPhoto(File photo) async {
    bool success = false;
    final firebaseService = FirebaseService();

    // Get the current timestamp
    final time = Timestamp.now();

    // Upload the photo to the server using FirebaseService
    success =
        await firebaseService.uploadPhotoToServer(photo: photo, time: time);

    // Refresh the list of photos after uploading
    await getPhotos();

    // Return the success status
    return success;
  }
}
