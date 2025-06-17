import 'dart:convert';

import 'package:all_implement_project/gemini_chat_bot_support/chat_bot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        spacing: 18,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'tag1',
            child: Image.asset(
              "assets/images/images-removebg-preview.png",
              height: 40,
            ),
            onPressed: () {},
          ),
          FloatingActionButton(
            heroTag: 'tag2',
            child: Image.asset(
              "assets/images/istockphoto-1294455829-612x612-removebg-preview.png",
              height: 40,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatBot()),
              );
            },
          ),
        ],
      ),
      appBar: AppBar(title: Text("All Previous Implement"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child:
                data.isNotEmpty
                    ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder:
                          (context, index) => ListTile(
                            leading: Text(data[index]["id"].toString()),
                            title: Text(data[index]["first_name"].toString()),
                            subtitle: Text(data[index]["email"].toString()),
                            trailing: Image.network(data[index]["avatar"]),
                          ),
                    )
                    : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataHomePage();
    super.initState();
  }

  List<dynamic> data = [];

  getDataHomePage() async {
    final response = await http.get(
      Uri.parse("https://reqres.in/api/users?page=2"),
    );
    final jsonDecoded = jsonDecode(response.body);
    final finalData = jsonDecoded["data"];

    data = finalData;

    print(finalData);

    setState(() {});
  }
}
