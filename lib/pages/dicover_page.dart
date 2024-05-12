import 'package:bottom_navigation_bar/pages/discover_child_pages/discover_child_page.dart';
import 'package:bottom_navigation_bar/views/discover_cell.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  Color _themeColor = Color.fromRGBO(220, 220, 220, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeColor,
        centerTitle: true,
        title: Text('发现'),
      ),
      body: Container(
        // padding: EdgeInsets.all(10),
        height: 800,
        color: _themeColor,
        child: ListView(
          children: [
            DiscoverCell(
              title: "朋友圈",
              imageName: "images/ad_icon3.png",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext contect) => DiscoverChildPage(
                          title: '朋友圈',
                        )));
                print('进入点击方法');
              },
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              title: "扫一扫",
              imageName: "images/ad_icon2.png",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext contect) => DiscoverChildPage(
                          title: '扫一扫',
                        )));
                print('进入点击方法');
              },
            ),
            //分割线
            Row(
              children: [
                Container(
                  width: 50,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ],
            ),
            DiscoverCell(
              title: "摇一摇",
              imageName: "images/ad_icon1.png",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext contect) => DiscoverChildPage(
                          title: '摇一摇',
                        )));
                print('进入点击方法');
              },
            )
          ],
        ),
      ),
    );
  }
}
