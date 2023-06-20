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
      body: PostCard(),
    );
  }
}
