import 'package:application_wisy/util/util.dart';
import 'package:application_wisy/providers/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:better_open_file/better_open_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

class CameraScreen extends ConsumerWidget {
  CameraScreen({super.key});

  File? capturedImage;
  Util util = Util();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoListNotifier = ref.read(photoListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Photo'),
      ),
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photo(
            pathBuilder: () async {
              final tempDirectory = await getTemporaryDirectory();
              final filePath = '${tempDirectory.path}.jpg';
              capturedImage = File(filePath);
              return filePath;
            },
          ),
          enablePhysicalButton: true,
          flashMode: FlashMode.auto,
          aspectRatio: CameraAspectRatios.ratio_16_9,
          previewFit: CameraPreviewFit.fitWidth,
          onMediaTap: (mediaCapture) async {
            if (capturedImage != null) {
              bool success = false;

              // Show a loading indicator
              util.showLoading(context);

              // Open the captured image
              OpenFile.open(capturedImage!.path);

              // Upload the captured image to the server
              success = await photoListNotifier.uploadPhoto(capturedImage!);

              if (success) {
                // Close the loading indicator
                util.closeLoading();
              }
            }
          },
        ),
      ),
    );
  }
}
