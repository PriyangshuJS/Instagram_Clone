import 'package:flutter/material.dart';
import 'package:instagram/utility/colors.dart';
import 'package:instagram/models/user.dart' as model;
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    // return Center(
    //     child: IconButton(
    //   onPressed: () {},
    //   icon: Icon(Icons.upload),
    // ));
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text("Post to"),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Post",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          )
        ],
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Write a Caption...",
                  border: InputBorder.none,
                ),
                maxLines: 8,
              ),
            ),
            SizedBox(
              height: 45,
              width: 45,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user.photoUrl),
                      fit: BoxFit.fill,
                      alignment: FractionalOffset.topCenter,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Divider(),
          ],
        ),
      ]),
    );
  }
}
