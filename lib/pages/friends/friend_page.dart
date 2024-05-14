import 'package:bottom_navigation_bar/app_config.dart';
import 'package:bottom_navigation_bar/pages/discover_pages/discover_child_page.dart';
import 'package:bottom_navigation_bar/pages/friends/friends_data.dart';
import 'package:flutter/material.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List<Friends> _headData = [
    Friends(
      imageAsset: 'images/群聊.png',
      name: '新的朋友',
    ),
    Friends(imageAsset: 'images/群聊.png', name: '群聊'),
    Friends(imageAsset: 'images/群聊.png', name: '标签'),
    Friends(imageAsset: 'images/群聊.png', name: '公众号'),
  ];

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
      body: Container(
        color: mainColor,
        child: ListView.builder(
          itemBuilder: _itemForRow,
          itemCount: _headData.length + friendsDatasource.length,
        ),
      ),
    );
  }

  Widget? _itemForRow(BuildContext context, int index) {
    //显示头部四个Cell
    if (index < _headData.length) {
      return _FriendCell(
        imageAsset: _headData[index].imageAsset,
        name: _headData[index].name,
      );
    }
    return _FriendCell(
      imageUrl: friendsDatasource[index - 4].imageUrl,
      name: friendsDatasource[index - 4].name,
      // groupTitle: friendsDatasource[index-4].indexLetter,
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
    return Container(
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

                      image: _buildImageProvider(),
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
            width: screenSize(context).width-55,
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
