import 'package:bottom_navigation_bar/pages/chat_page.dart';
import 'package:bottom_navigation_bar/pages/discover_pages/dicover_page.dart';
import 'package:bottom_navigation_bar/pages/friends/friend_page.dart';
import 'package:bottom_navigation_bar/pages/mine_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 1;
  List<Widget> pages = [ChatPage(), FriendPage(), DiscoverPage(), MinePage()];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          // type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          selectedLabelStyle: TextStyle(color: Colors.green),
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/ad_icon0.png'),
                  height: 24,
                ),
                label: "首页"),
            BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_num_sharp), label: "通讯录"),
            BottomNavigationBarItem(icon: Icon(Icons.disc_full), label: "发现"),
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on_outlined), label: "我的"),
          ]),
    ));
  }
}
