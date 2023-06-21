import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/widgets/post_card.dart';
import '../utility/colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/PngItem_676474.png",
          color: primaryColor,
          height: 32,
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.message_outlined))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          }),
    );
  }
}
