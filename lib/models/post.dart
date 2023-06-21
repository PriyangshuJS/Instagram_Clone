import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String uid;
  final String description;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  // ignore: prefer_typing_uninitialized_variables
  final likes;

  const Post({
    required this.username,
    required this.uid,
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapsort = snap.data() as Map<String, dynamic>;
    print(snapsort.toString());
    return Post(
      username: snapsort["Username"],
      uid: snapsort["UID"],
      description: snapsort["description"],
      postId: snapsort["postId"],
      datePublished: snapsort["datePublished"],
      postUrl: snapsort["postUrl"],
      profImage: snapsort["profImage"],
      likes: snapsort["likes"],
    );
  }
}
