import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/utility/colors.dart';

import '../utility/global_var.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), labelText: "Search for a user"),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUser = true;
              });
              print("For _ ----------------$_");
              print("For Cont----------------${searchController.text}");
              print("For Cont----------------$isShowUser");
            },
          ),
        ),
      ),
      body: isShowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("User")
                  .where("username",
                      isGreaterThanOrEqualTo: searchController.text)
                  .where('username', isLessThan: searchController.text + "z")
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  print("HERE1-----------------------------00");
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print("HERE2-----------------------------");
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    print(
                        "Here3---------------------------${(snapshot.data! as dynamic).docs[index]["uid"]}");
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfileScreen(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ["uid"],
                            );
                          },
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]
                                ["profileUrl"],
                          ),
                          radius: 16,
                        ),
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]["username"],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("Posts")
                  .orderBy("datePublished")
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => ClipRRect(
                    //borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      snapshot.data!.docs[index]['postUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  staggeredTileBuilder: (index) =>
                      (MediaQuery.of(context).size.width > webScreenSize)
                          ? StaggeredTile.count(
                              (index % 7 == 0) ? 1 : 1,
                              (index % 7 == 0) ? 1 : 1,
                            )
                          : StaggeredTile.count(
                              (index % 7 == 0) ? 2 : 1,
                              (index % 7 == 0) ? 2 : 1,
                            ),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              },
            ),
    );
  }
}
