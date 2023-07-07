import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ListSampleApp());
}

class ListSampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MessageItem> items = [];

  TextEditingController _textEditingController = TextEditingController();

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8080/message'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        items = List<MessageItem>.from(
          data['items'].map((item) => MessageItem.fromMap(item)),
        );
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message List')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: '请输入',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform publish action here using _textEditingController.text
                  },
                  child: Text('发布'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text('Content: ${item.content}'),
                      subtitle: Text('ID: ${item.id}'),
                    ),
                    ListTile(
                      title: Text('Formatted Time: ${item.formattedTime}'),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MessageItem {
  final String content;
  final int id;
  final DateTime time;
  late final String formattedTime;

  MessageItem({
    required this.content,
    required this.id,
    required this.time,
  }) {
    formattedTime = '${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}';
  }

  factory MessageItem.fromMap(Map<String, dynamic> map) {
    return MessageItem(
      content: map['content'] ?? "",
      id: map['id'],
      time: DateTime.parse(map['time']),
    );
  }
}