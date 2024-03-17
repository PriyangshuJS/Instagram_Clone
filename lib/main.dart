import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:instagram/providers/user_provider.dart';

import 'package:instagram/responsive/mobile_screen_layout.dart';

import 'package:instagram/responsive/responsive_layout_screen.dart';

import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/signup_screen.dart';

import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: SignupScreen(),
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.active) {
        //       if (snapshot.hasData) {
        //         return const ResponsiveLayoutScreen(
        //           mobileScreenlayout: MobileScreenLayout(),
        //           webScreenlayout: WebScreenLayout(),
        //         );
        //       } else if (snapshot.hasError) {
        //         return Center(
        //           child: Text("${snapshot.error}"),
        //         );
        //       }
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(color: primaryColor),
        //       );
        //     }
        //     return const LoginScreen();
        // },
        //  ),
      ),
    );
  }
}
