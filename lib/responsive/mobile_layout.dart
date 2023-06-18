import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart' as model;
import 'package:instagram/provider/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  String username = "";
  @override
  void initState() {
    super.initState();
    getusername();
  }

  void getusername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)["Username"];
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Text(user.username),
      ),
    );
  }
}
