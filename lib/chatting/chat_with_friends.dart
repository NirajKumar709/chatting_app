import 'package:flutter/material.dart';

class ChatWithFriends extends StatefulWidget {
  const ChatWithFriends({super.key});

  @override
  State<ChatWithFriends> createState() => _ChatWithFriendsState();
}

class _ChatWithFriendsState extends State<ChatWithFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatting with friends"), centerTitle: true),
      body: Column(
        children: [
          Expanded(child: Text("data")),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
