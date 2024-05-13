import 'package:bottom_navigation_bar/pages/discover_child_pages/discover_child_page.dart';
import 'package:bottom_navigation_bar/views/discover_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  Widget headWidget() {
    return Container(
      height: 200,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color.fromRGBO(220, 220, 220, 1),
          child: Stack(
            children: [
              //列表
              Container(
                // MediaQuery.removePadding：移除Flutter官方封装的一些属性。flutter子部件默认有边距
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(children: [
                    headWidget(),
                    DiscoverCell(
                      title: "朋友圈",
                      imageName: "images/ad_icon3.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext contect) =>
                                DiscoverChildPage(
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
                            builder: (BuildContext contect) =>
                                DiscoverChildPage(
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
                            builder: (BuildContext contect) =>
                                DiscoverChildPage(
                                  title: '摇一摇',
                                )));
                        print('进入点击方法');
                      },
                    )
                  ]),
                ),
              ),
              //相机
              Container(
                color: Colors.red,
                margin: EdgeInsets.only(top: 48, right: 15),
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Icon(Icons.camera_alt)],
                ),
              )
            ],
          )),
    );
  }
}
