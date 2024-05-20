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
  int _currentIndex = 0;
  List<Widget> _pages = [ChatPage(), FriendPage(), DiscoverPage(), MinePage()];
  //setState要重新渲染，重新种树，重新创建对象
  //通过PageController内部切换，不会重新渲染，_pages的所有页面都会放在PageController的children里，所有页面都在widget树里面。通过jump的方式跳转
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      //     不直接使用_pages[_currentIndex]，因为会重新渲染页面。PageView+PageController来跳转
      // body: _pages[_currentIndex],
      body: PageView(
        // 不允许拖拽
        physics: NeverScrollableScrollPhysics(),
        // 拖拽后，页面回调，切换tabbar写到这里
        // onPageChanged: (int index){_currentIndex = index;setState(() {
        //
        // });},
        controller: _controller,
        //
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              //此处需要跳转
              _controller.jumpToPage(_currentIndex);
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
