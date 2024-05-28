import 'package:bottom_navigation_bar/app_config.dart';
import 'package:bottom_navigation_bar/pages/chat/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.dataSource});

  final List<ChatModel>? dataSource;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchStr = '';
  List<ChatModel> _resultModels = [];

  void _searchData(String text) {
    _resultModels.clear(); //每次搜索先清空
    _searchStr = text;
    if (text.length > 0) {
      for (int i = 0; i < widget.dataSource!.length; i++) {
        String name = widget.dataSource![i].name!;
        if (name.contains(text)) {
          _resultModels.add(widget.dataSource![i]);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: SearchBar(),
      //   backgroundColor: mainColor,
      // ),
      body: Column(
        children: [
          SearchBar(
            onChanged: (String text) {
              _searchData(text);
            },
          ),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                itemCount: _resultModels.length,
                itemBuilder: _buildCellForRow,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildCellForRow(BuildContext context, int index) {
    return ListTile(
      title: _title(_resultModels[index].name!),
      subtitle: Container(
        alignment: Alignment.bottomLeft, //对齐底部
        padding: EdgeInsets.only(right: 10),
        height: 20,
        child: Text(
          _resultModels[index].message!,
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
                image: NetworkImage(_resultModels[index].imageUrl!))),
      ),
    );
  }

  //搜索字段高亮
  TextStyle _normalStyle = TextStyle(fontSize: 16, color: Colors.black);
  TextStyle _heightLightedStyle = TextStyle(fontSize: 16, color: Colors.green);

  Widget _title(String name) {
    List<TextSpan> spans = [];
    //name.split(_searchStr) 使用_searchStr字符将name字符分割成一个数组
    //出现空字符串有以下三种情况
    // 1、以这个字符开头
    // 2、以这个字符结尾
    // 3、相邻的两个此字符串
    List<String> strs = name.split(_searchStr);
    for (int i = 0; i < strs.length; i++) {
      String str = strs[i];
      if (str == '' && i < strs.length - 1) {
        //以这个字符开头，相邻的两个此字符串 两种情况 末尾除外（因为情况2的时候在前一个元素处理时已经加过一次了）
        spans.add(TextSpan(text: _searchStr, style: _heightLightedStyle));
      } else {
        //每个元素添加之后跟随添加一个分割元素，末尾除外（因为情况2的时候在前一个元素处理时已经加过了）
        spans.add(TextSpan(text: str, style: _normalStyle));
        if (i < strs.length - 1) {
          spans.add(TextSpan(text: _searchStr, style: _heightLightedStyle));
        }
      }
    }
    print(strs);
    return RichText(
      text: TextSpan(children: spans),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const SearchBar({super.key, this.onChanged});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;

  void _onChange(String text) {
    //给外部回调
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
    setState(() {
      _showClear = text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          height: 44,
          color: Colors.red,
          child: Row(
            children: [
              Container(
                width: screenSize(context).width - 40,
                height: 34,
                margin: EdgeInsets.only(left: 5, right: 5),
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                // color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.grey,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _controller,
                        onChanged: _onChange,
                        autofocus: true,
                        cursorColor: Colors.green,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 5, bottom: 10),
                            border: InputBorder.none,
                            hintText: '搜索'),
                      ),
                    ),
                    if (_showClear)
                      GestureDetector(
                        onTap: () {
                          _controller.clear();
                          setState(() {
                            _onChange('');
                          });
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
