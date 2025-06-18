import 'package:all_implement_project/main.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatWithFriends extends StatefulWidget {
  final String friendUserId;
  final String friendName;

  const ChatWithFriends({
    super.key,
    required this.friendUserId,
    required this.friendName,
  });

  @override
  State<ChatWithFriends> createState() => _ChatWithFriendsState();
}

class _ChatWithFriendsState extends State<ChatWithFriends> {
  List<DocumentSnapshot> allMessage = [];

  @override
  void initState() {
    // TODO: implement initState
    getMessage();
    super.initState();
  }

  getMessage() async {
    List<String> ids = [widget.friendUserId, myUserId];
    ids.sort();
    String joinedDocId = ids.join("_");

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection("chat")
            .doc(joinedDocId)
            .collection("message")
            .get();

    allMessage.addAll(snapshot.docs);

    setState(() {});
  }

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.friendUserId);
    print(myUserId);

    List<String> ids = [widget.friendUserId, myUserId];
    ids.sort();
    String joinedId = ids.join("_");

    print(joinedId);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friendName.toString()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child:
                allMessage.isNotEmpty
                    ? ListView.builder(
                      itemCount: allMessage.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> userData =
                            allMessage[index].data() as Map<String, dynamic>;

                        return BubbleSpecialThree(
                          text: userData["message_conversation"],
                          color: Color(0xFFE8E8EE),
                          tail: true,
                          isSender: false,
                        );
                      },
                    )
                    : Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Search",
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
                      joinedDocId: joinedId,
                    );

                    allMessage.clear();
                    getMessage();

                    messageController.clear();
                    setState(() {});
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

  sendMessage({required String message, required String joinedDocId}) async {
    await FirebaseFirestore.instance
        .collection("chat")
        .doc(joinedDocId)
        .collection("message")
        .doc()
        .set({"message_conversation": message});
  }
}
