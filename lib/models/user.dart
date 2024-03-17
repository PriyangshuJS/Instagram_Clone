import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String photoUrl;
  final String email;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'following': following,
        'followers': followers,
        'photoUrl': photoUrl,
      };

  factory User.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username:
          snapshot.toString().contains('username') ? snapshot['username'] : '',
      uid: snapshot.toString().contains('uid') ? snapshot['uid'] : '',
      email: snapshot.toString().contains('email') ? snapshot['email'] : '',
      photoUrl:
          snapshot.toString().contains('photoUrl') ? snapshot['photoUrl'] : '',
      bio: snapshot.toString().contains('bio') ? snapshot['bio'] : '',
      followers: snapshot.toString().contains('followers')
          ? snapshot['followers']
          : [],
      following: snapshot.toString().contains('following')
          ? snapshot['following']
          : [],
    );
  }
}
