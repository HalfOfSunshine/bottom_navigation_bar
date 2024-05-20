import 'dart:convert';

import 'package:bottom_navigation_bar/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

//保数据 - 第1步  with AutomaticKeepAliveClientMixin<ChatPage>
class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin<ChatPage> {
  List<ChatModel> _datas = [];
  bool _cancelConnect = false;

  // wantKeepAlive
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<List<ChatModel>> future = getDatas();
    //Future相当于是一个封装了返回用的block的类。   应该只是为了便于初学者理解
    future
        .then((List<ChatModel> datas) {
          if (!_cancelConnect) {
            setState(() {
              _datas = datas;
            });
          }
        })
        .catchError((e) {
          _cancelConnect = true;
          print(e);
        })
        .whenComplete(() {
          print('完毕');
        })
        .timeout(Duration(seconds: 1))
        .catchError((timeout) {
          print('$timeout');
          _cancelConnect = true;
        });
  }

//网络请求异步
  Future<List<ChatModel>> getDatas() async {
    //这里为什么要用setState()?直接_cancelConnect = false;不行吗？
    // setState(() {
    //   _cancelConnect = false;
    // });
    _cancelConnect = false;
    // http://rap2api.taobao.org/app/mock/318911/api/chat/list
    var url = Uri.http('rap2api.taobao.org', 'app/mock/318911/api/chat/list');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      // List<ChatModel> result = ChatModel.forMap(responseBody['chat_list']) as List<ChatModel>;
      //map() 遍历取出内容
      List<ChatModel> chatList = responseBody['chat_list']
          .map<ChatModel>((item) => ChatModel.forMap(item))
          .toList();
      return chatList;
    } else {
      throw Exception('statusCode:${response.statusCode}');
    }

    print('${response.statusCode}');
    print('${response.body}');
    // json转模型
    final chat = {
      'name': '张三',
      'message': '12345',
    };
    final chatJson = json.encode(chat);
    final newChat = json.decode(chatJson);
    print('$newChat');
  }

  _buildPopupMenuItem(IconData icon, String str) {
    return PopupMenuItem(
        child: Row(
      children: [
        Icon(
          icon,
          weight: 20,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          str,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    //保数据 - 第3步
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        backgroundColor: mainColor,
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
                color: Color.fromRGBO(1, 1, 1, 0.6),
                offset: Offset(-10, 30),
                child: Icon(
                  Icons.add_circle_outline,
                  size: 25,
                ),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem>[
                    _buildPopupMenuItem(Icons.group, '发起群聊'),
                    _buildPopupMenuItem(Icons.qr_code_scanner, '扫一扫'),
                    _buildPopupMenuItem(Icons.add, '添加朋友'),
                    _buildPopupMenuItem(Icons.payment, '首付款'),
                  ];
                }),
          ),
        ],
      ),
      body: Container(
        child: Container(
          child: _datas.length == 0
              ? Center(
                  child: Text('加载中'),
                )
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_datas[index].name!),
                    subtitle: Container(
                      alignment: Alignment.bottomLeft, //对齐底部
                      padding: EdgeInsets.only(right: 10),
                      height: 20,
                      child: Text(
                        _datas[index].message!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(_datas[index].imageUrl!))),
                    ),
                  );
                }),
        ),
        // child: FutureBuilder(
        //   //FutureBuilder 中future: getDatas()获得的数据最终会给到snapshot.data
        //   future: getDatas(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.hasError) {
        //         // 请求失败，显示错误
        //         return Text("Error: ${snapshot.error}");
        //       } else {
        //         // 请求成功，显示数据
        //         return ListView(
        //           children: snapshot.data.map<Widget>((ChatModel item) {
        //             return ListTile(
        //               title: Text(item.name!),
        //               subtitle: Container(
        //                 alignment: Alignment.bottomLeft, //对齐底部
        //                 padding: EdgeInsets.only(right: 10),
        //                 height: 20,
        //                 child: Text(
        //                   item.message!,
        //                   overflow: TextOverflow.ellipsis,
        //                   style: TextStyle(color: Colors.grey, fontSize: 13),
        //                 ),
        //               ),
        //               // leading: CircleAvatar(
        //               //   backgroundImage: NetworkImage(item.imageUrl!),
        //               // ),
        //               leading: Container(
        //                 width: 44,
        //                 height: 44,
        //                 decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(10),
        //                     image: DecorationImage(
        //                         image: NetworkImage(item.imageUrl!))),
        //               ),
        //             );
        //           }).toList(),
        //         );
        //       }
        //     } else {
        //       // 请求未结束，显示loading
        //       return CircularProgressIndicator();
        //     }
        //   },
        // ),
      ),
    );
  }
  //保数据 - 第2步
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ChatModel {
  final String? name;
  final String? message;
  final String? imageUrl;

  ChatModel({this.name, this.message, this.imageUrl});

  factory ChatModel.forMap(Map map) {
    return ChatModel(
        name: map['name'], message: map['message'], imageUrl: map['image_url']);
  }
}
