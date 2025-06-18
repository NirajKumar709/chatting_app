import 'package:all_implement_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String friendUid;
  final String friendName;

  const Chat({super.key, required this.friendUid, required this.friendName});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(myUserId);
    print(widget.friendUid);
    print("________________________________________________");

    List<String> uIds = [myUserId, widget.friendUid];
    uIds.sort();
    String joinedId = uIds.join("_");

    print(joinedId);

    return Scaffold(
      appBar: AppBar(title: Text(widget.friendName), centerTitle: true),
      body: Column(
        children: [
          Expanded(child: Text("data")),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Chat with friends",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage(
                      message: messageController.text,
                      joinedUserId: joinedId,
                    );
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  sendMessage({required String message, required String joinedUserId}) {
    FirebaseFirestore.instance
        .collection("chat_friends")
        .doc(joinedUserId)
        .collection("chat_message")
        .doc()
        .set({"friends_message": message});
  }
}
