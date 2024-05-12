import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1.0),

        centerTitle: true,
      ),
      body: const Center(
        child: Text('首页'),
      ),
    );
  }
}
