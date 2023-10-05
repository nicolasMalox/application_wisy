import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'server/firebase_options.dart';

//Screens
import 'package:application_wisy/screens/camera_screen.dart';
import 'package:application_wisy/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter My favourite books',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/camera': (context) => CameraScreen(),
      },
    );
  }
}
