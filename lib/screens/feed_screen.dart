import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utility/global_var.dart';
import 'package:instagram/widgets/post_card.dart';
import '../utility/colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (MediaQuery.of(context).size.width > webScreenSize)
          ? webBackgroundColor
          : mobileBackgroundColor,
      appBar: (MediaQuery.of(context).size.width > webScreenSize)
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width > webScreenSize)
                    ? MediaQuery.of(context).size.width * 0.3
                    : 0,
                vertical: (MediaQuery.of(context).size.width > webScreenSize)
                    ? 15
                    : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
