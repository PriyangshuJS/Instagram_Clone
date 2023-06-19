import 'package:flutter/material.dart';
import 'package:instagram/screens/upload_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Center(
    child: Text("Home"),
  ),
  Center(
    child: Text("Seach"),
  ),
  UploadScreen(),
  Center(
    child: Text("Favorites"),
  ),
  Center(
    child: Text("Profile"),
  )
];
