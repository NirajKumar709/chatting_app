import 'package:all_implement_project/chat_application/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DocumentSnapshot> userData = [];

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  getUser() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("user").get();
    userData.addAll(snapshot.docs);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All user here"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child:
                userData.isNotEmpty
                    ? ListView.builder(
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> finalData =
                            userData[index].data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Chat(
                                      friendUid: userData[index].id,
                                      friendName: finalData["name"],
                                    ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(finalData["name"]),
                            subtitle: Text(finalData["email"]),
                          ),
                        );
                      },
                    )
                    : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
