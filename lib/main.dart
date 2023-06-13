import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/responsive/mobile_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/web_layout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utility/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCNxg67asAKmJfrO_v9-iysfo9RCBQOyj0",
        appId: "1:766995623260:web:19afc9578b5c02ad15e599",
        messagingSenderId: "766995623260",
        projectId: "instagram-clone-cfee1",
        storageBucket: "instagram-clone-cfee1.appspot.com",
        authDomain: "instagram-clone-cfee1.firebaseapp.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const Responsive_Layout(
      //   mobileScreenLayout: Mobile_Layout(),
      //   webScreenLayout: Web_Layout(),
      // ),
      home: const Login_Screen(),
    );
  }
}
