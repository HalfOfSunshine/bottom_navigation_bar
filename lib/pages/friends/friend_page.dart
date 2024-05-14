import 'package:bottom_navigation_bar/app_config.dart';
import 'package:bottom_navigation_bar/pages/discover_pages/discover_child_page.dart';
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
        title: const Text('通讯录'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const DiscoverChildPage(
                        title: '添加朋友',
                      )));
            },
            child: Container(
              width: 50,
              height: 50,
              child: const Icon(Icons.supervisor_account),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: const Center(
        child: Text('通讯录'),
      ),
    );
  }
}
