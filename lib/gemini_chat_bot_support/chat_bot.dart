import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  TextEditingController messageController = TextEditingController();

  List<DataModel> data = [];

  sendMessage({required String message}) {
    data.add(DataModel(message: message, isSender: true));
    print(message);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat With Ai"), centerTitle: true),
      body: Column(
        children: [
          Expanded(child: Text(data.toString())),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Search for anything",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage(message: messageController.text);
                    aiMessage(message: messageController.text);

                    messageController.clear();
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

  aiMessage({required String message}) async {
    final response = await http.post(
      Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyAnjNP4scx0m0LF0G1Gk8mGapGqh31p1hY",
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": message},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final jsonDecoded = jsonDecode(response.body);
      final aiDataStore =
          jsonDecoded["candidates"][0]["content"]["parts"][0]["text"];

      data.add(DataModel(message: aiDataStore, isSender: false));
      print(aiDataStore);
    }
  }
}

class DataModel {
  final String message;
  final bool isSender;

  DataModel({required this.message, required this.isSender});
}
