import 'package:bottom_navigation_bar/app_config.dart';
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
        backgroundColor: mainColor,

        centerTitle: true,
      ),
      body: const Center(
        child: Text('首页'),
      ),
    );
  }
}
