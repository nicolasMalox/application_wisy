import 'package:application_wisy/providers/firebase_provider.dart';
import 'package:application_wisy/widgets/item_card.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My favourite books'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigates to the camera screen
              Navigator.pushNamed(context, '/camera');
            },
            child: const Text('Upload new photo'),
          ),
          const Expanded(
            // Displays the list of photos
            child: PhotosListView(),
          ),
        ],
      ),
    );
  }
}

class PhotosListView extends ConsumerWidget {
  const PhotosListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listens for changes in the list of photos
    final photos = ref.watch(photoListProvider);

    if (photos.isEmpty) {
      // Displays a loading indicator if the list is empty
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Info: ${photo.timestamp.toString()}', // Displays the timestamp of the photo
                  overflow:
                      TextOverflow.fade, // Allows text to fade if it overflows
                  style: const TextStyle(fontSize: 18.0),
                ),
                Row(
                  children: [
                    const Text('Copy URL link'),
                    IconButton(
                      icon: const Icon(Icons.content_copy),
                      onPressed: () async {
                        // Copies the URL to the clipboard
                        Clipboard.setData(ClipboardData(text: photo.url));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('copied URL link')),
                        );
                      },
                    ),
                  ],
                ),
                // Displays an item card for the photo
                ItemCard(photo: photo),
              ],
            ),
          );
        },
      );
    }
  }
}
