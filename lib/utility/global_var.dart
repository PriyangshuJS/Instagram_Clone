import 'package:flutter/material.dart';
import 'package:instagram/screens/post_upload_screen.dart';
import 'package:instagram/screens/search_screen.dart';
import '../screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  UploadScreen(),
  Center(
    child: Text("Favorites"),
  ),
  Center(
    child: Text("Profile"),
  )
];
