import 'package:bottom_navigation_bar/pages/discover_pages/discover_child_page.dart';
import 'package:bottom_navigation_bar/views/discover_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  MethodChannel _methodChannel = MethodChannel('mine_page/method');
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodChannel.setMethodCallHandler((call) {
      print("进来了");
      if(call.method == 'imagePath'){
        print(call.arguments);
        String imagePath = call.arguments.toString();
      }
      return Future(() {

      });
    });
  }
  Widget headWidget() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Container(
        child: Container(
          margin:
          const EdgeInsets.only(left: 10, top: 100, bottom: 10, right: 10),
          color: Colors.white,
          child: Row(
            children: [
              // 头像
              GestureDetector(
                onTap: () {
                  _methodChannel.invokeMapMethod('picture');
                },
                child: Container(
                  width: 70,
                  height: 70,
                  // color: Colors.blue,
                  // child: Image(
                  //   image: AssetImage('images/avatar.jpg'),
                  // ),
                  // BoxDecoration:装饰容器，与外面的冲突,外面的child会覆盖掉BoxDecoration，因此使用DecorationImage
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage('images/avatar.jpg'),
                        fit: BoxFit.cover, //填充模式，类似UIViewContentMode
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                        ),
                      ]),
                ),
              ),
              //右边的部分
              Expanded(
                // padding: const EdgeInsets.only(left: 10, top: 8, right: 10),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Column(
                    //实现左对齐
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.red,
                        child: const Text(
                          '微信昵称',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '微信号：1234',
                              style:
                              TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                      title: "支付",
                      imageName: "images/ad_icon3.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const DiscoverChildPage(
                              title: '支付',
                            )));
                        print('进入点击方法');
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      title: "收藏",
                      imageName: "images/ad_icon2.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DiscoverChildPage(
                                  title: '收藏',
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
                      title: "卡包",
                      imageName: "images/ad_icon1.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DiscoverChildPage(
                                  title: '卡包',
                                )));
                        print('进入点击方法');
                      },
                    )
                  ]),
                ),
              ),
              //相机
              Container(
                color: Colors.white,
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
