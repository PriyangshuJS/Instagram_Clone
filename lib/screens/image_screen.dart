import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/colors.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          "LinkOne",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StaggeredGridView.countBuilder(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              crossAxisCount: 3,
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => Image.network(
                  (snapshot.data! as dynamic).docs[index]['postUrl']),
              staggeredTileBuilder: (index) => StaggeredTile.count(
                (index % 7 == 0) ? 2 : 1,
                (index % 7 == 0) ? 2 : 1,
              ),
            );
          },
        ),
      ),
    );
  }
}
