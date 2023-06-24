import "dart:async";
import "dart:typed_data";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:instagram/models/user.dart" as model;
import "package:instagram/resources/storage_methord.dart";

class AuthMethord {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetail() async {
    //User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("User").doc(_auth.currentUser!.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String username,
    required String bio,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Some Error";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        String profileUrl = await StorageMethord()
            .uploadImagetoStorage("ProfileImage", file, false);

        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: profileUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );
        _firestore.collection("User").doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "success";
      }
    } catch (error) {
      res = error.toString();
    }
    print(res);
    return res;
  }

  Future<String> loginInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some Error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Enter all the Fields";
      }
    } catch (error) {
      res = error.toString();
    }

    return res;
  }
}
