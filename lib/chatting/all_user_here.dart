import 'package:all_implement_project/chatting/chat_with_friends.dart';
import 'package:all_implement_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUserHere extends StatefulWidget {
  const AllUserHere({super.key});

  @override
  State<AllUserHere> createState() => _AllUserHereState();
}

class _AllUserHereState extends State<AllUserHere> {
  @override
  void initState() {
    // TODO: implement initState
    getAllUser();
    super.initState();
  }

  List<DocumentSnapshot> dataStore = [];

  getAllUser() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("newUsers").get();

    dataStore.addAll(snapshot.docs);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userId)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:
                dataStore.isNotEmpty
                    ? ListView.builder(
                      itemCount: dataStore.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> personData =
                            dataStore[index].data() as Map<String, dynamic>;

                        if (dataStore[index].id == userId) {
                          return SizedBox();
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatWithFriends(),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(personData["name"]),
                              subtitle: Text(personData["email"]),
                            ),
                          );
                        }
                      },
                    )
                    : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
