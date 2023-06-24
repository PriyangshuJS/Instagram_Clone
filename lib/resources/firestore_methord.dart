import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/resources/storage_methord.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethors {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some Internal Error!!";
    try {
      String postUrl =
          await StorageMethord().uploadImagetoStorage("Post", file, true);

      String postId = const Uuid().v1();
      Post post = Post(
        username: username,
        uid: uid,
        description: description,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        profImage: profImage,
        likes: [],
      );
      _firestore.collection("Posts").doc(postId).set(post.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("Posts").doc(postId).update(
          {
            "likes": FieldValue.arrayRemove([uid])
          },
        );
      } else {
        await _firestore.collection("Posts").doc(postId).update(
          {
            "likes": FieldValue.arrayUnion([uid])
          },
        );
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection("Posts")
            .doc(postId)
            .collection("Comment")
            .doc(commentId)
            .set(
          {
            'profilePic': profilePic,
            'name': name,
            'uid': uid,
            'text': text,
            'likes': [],
            'commentId': commentId,
            'datePublished': DateTime.now(),
          },
        );
      } else {
        print("Comment Text is Empty");
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection("Posts").doc(postId).delete();
    } catch (err) {
      err.toString();
    }
  }
}
