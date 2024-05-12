import 'package:flutter/material.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通讯录'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1.0),

      ),
      body: const Center(
        child: Text('通讯录'),
      ),
    );
  }
}
