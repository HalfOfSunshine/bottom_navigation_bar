import 'dart:math';

import 'package:bottom_navigation_bar/app_config.dart';
import 'package:bottom_navigation_bar/pages/discover_pages/discover_child_page.dart';
import 'package:bottom_navigation_bar/pages/friends/friends_data.dart';
import 'package:bottom_navigation_bar/pages/friends/index_bar.dart';
import 'package:flutter/material.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  //字典，里面放高度对应的数据，计算得出,再设置UI的位置计算，initState()
  final double _cellHeight = 54.2;
  final double _groupHeight = 30;
  late double _groupOffset;
  final Map _groupOffSetMap = {};
  final List<Friends> _headData = [
    Friends(
      imageAsset: 'images/群聊.png',
      name: '新的朋友',
    ),
    Friends(imageAsset: 'images/群聊.png', name: '群聊'),
    Friends(imageAsset: 'images/群聊.png', name: '标签'),
    Friends(imageAsset: 'images/群聊.png', name: '公众号'),
  ];
  final List<Friends> _listData = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    // TODO: implement initState
    super.initState();
    // _listData.addAll(friendsDatasource);
    //  添加多次，链式语法
    _listData
      ..addAll(friendsDatasource)
      ..addAll(friendsDatasource);
    //排序
    _listData.sort((Friends a, Friends b) {
      return a.indexLetter!.compareTo(b.indexLetter!);
    });
    _groupOffset = _cellHeight * _headData.length;
    //计算头位置
    for (int i = 0; i < _listData.length; i++) {
      if (i < 1) {
        //第一个cell一定有头
        _groupOffSetMap.addAll({_listData[i].indexLetter: _groupOffset});
        //保存完了再+_groupHeight
        _groupOffset += _cellHeight + _groupHeight;
      } else if (_listData[i].indexLetter == _listData[i - 1].indexLetter) {
        //增加高度即可，同一个头不多次存储
        _groupOffset += _cellHeight;
      } else {
        _groupOffSetMap.addAll({_listData[i].indexLetter: _groupOffset});
        //保存完了再+_groupHeight
        _groupOffset += _cellHeight + _groupHeight;
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 获取屏幕高度
    double screenHeight = MediaQuery.of(context).size.height;
    // 获取AppBar高度
    double appBarHeight = AppBar().preferredSize.height;
    // 获取BottomNavigationBar高度
    double bottomNavHeight = kBottomNavigationBarHeight;
    // 获取安全区的高度
    double topPadding = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    // 可用的屏幕高度
    double availableHeight = screenHeight - appBarHeight - bottomNavHeight - topPadding - bottomPadding;
    double maxOffset = max(0, _groupOffset + _groupHeight - availableHeight);
    print('======$maxOffset');
    for (String key in _groupOffSetMap.keys.toList()) {
      if (_groupOffSetMap[key]! > maxOffset) {
        _groupOffSetMap[key] = maxOffset;
      }
    }
  }
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
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Icon(Icons.supervisor_account),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: mainColor,
        ),
        body: Stack(
          children: [
            Container(
              color: mainColor,
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: _itemForRow,
                itemCount: _headData.length + _listData.length,
              ),
            ),
            IndexBar(
              indexBarCallBack: (String str) {
                if (_groupOffSetMap[str] != null) {
                  _scrollController.animateTo(_groupOffSetMap[str],
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }
              },
            ), //悬浮条
          ],
        ));
  }

  Widget? _itemForRow(BuildContext context, int index) {
    //显示头部四个Cell
    if (index < _headData.length) {
      return _FriendCell(
        imageAsset: _headData[index].imageAsset,
        name: _headData[index].name,
      );
    }
    //剩下的cell
    //不显示组名字
    bool hiddenGroupTitle = (index - 4 > 0 &&
        _listData[index - 4].indexLetter == _listData[index - 5].indexLetter);
    //显示组名字
    return _FriendCell(
      imageUrl: _listData[index - 4].imageUrl,
      name: _listData[index - 4].name,
      groupTitle: hiddenGroupTitle ? null : _listData[index - 4].indexLetter,
    );
  }
}

class _FriendCell extends StatelessWidget {
  const _FriendCell(
      {super.key,
      this.imageUrl,
      this.name,
      this.groupTitle,
      this.imageAsset}); //下划线_表示私有,跨文件私有,统一文件下不同类可以i使用
  final String? imageUrl;
  final String? name;
  final String? groupTitle;
  final String? imageAsset; //本地图片
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: groupTitle != null ? 30 : 0,
          color: mainColor,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          child: groupTitle != null
              ? Text(
                  '$groupTitle',
                  style: TextStyle(color: Colors.grey),
                )
              : null,
        ), //头部
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  //图片
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        image: DecorationImage(
                          // image: imageUrl != null?NetworkImage(imageUrl!):AssetImage(imageAsset!),

                          // image: _buildImageProvider(),
                          image: imageUrl != null
                              ? NetworkImage(imageUrl!) as ImageProvider
                              : AssetImage(imageAsset!),
                        )),
                  ),
                  //昵称
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$name',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              //下划线 安卓自带下划线，苹果没有
              Container(
                color: Colors.grey,
                width: screenSize(context).width - 55,
                height: 0.2,
                // child: Row(
                //   children: [
                //     Container(
                //       height: 0.2,
                //       width: 55,
                //       color: Colors.white,
                //     )
                //   ],
                // ),
              ),
            ],
          ),
        ) //Cell内容
      ],
    );
  }

  ImageProvider _buildImageProvider() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return NetworkImage(imageUrl!);
    } else if (imageAsset != null && imageAsset!.isNotEmpty) {
      return AssetImage(imageAsset!);
    } else {
      // Provide a default image or handle the case when both imageUrl and imageAsset are null or empty
      return AssetImage(
          'assets/群聊.png'); // Ensure you have a default image in your assets
    }
  }
}
