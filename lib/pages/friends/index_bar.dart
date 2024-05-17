import 'dart:ffi';

import 'package:bottom_navigation_bar/app_config.dart';
import 'package:flutter/material.dart';

class IndexBar extends StatefulWidget {
  const IndexBar({super.key, this.indexBarCallBack});

  final void Function(String str)? indexBarCallBack;

  @override
  State<IndexBar> createState() => _IndexBarState();
}

/*选中item字符*/
int getIndex(BuildContext context, Offset globalPosition) {
  //拿到当前小部件的盒子
  RenderBox? box = context.findRenderObject() as RenderBox?;
  //拿到Y值，globalToLocal当前位置小部件的原点（小部件右上角）的距离（x,y）
  double? y = box?.globalToLocal(globalPosition).dy;
  //算出字符的高度
  var itemHeight = screenSize(context).height / 2 / INDEX_WORDS.length;
  //算出第几个item ，clamp限制范围
  int index = y! ~/ itemHeight.clamp(0, INDEX_WORDS.length - 1);
  return index;
  // print('现在选中了${INDEX_WORDS[index]}');
}

class _IndexBarState extends State<IndexBar> {
  Color _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;
  double _indicatorY = 0.0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    //setState会重新走Build方法，因此_words放外面无法改变状态。改变的是UI的描述，描述改变UI也会改变，
    final List<Widget> _words = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      _words.add(Expanded(
          child: Text(
        INDEX_WORDS[i],
        style: TextStyle(fontSize: 10, color: _textColor),
      )));
    }
    return Positioned(
        right: 0.0,
        top: screenSize(context).height / 8,
        height: screenSize(context).height / 2,
        width: 70,
        child: Row(
          children: [
            Container(
              width: 50,
              alignment: Alignment(0, _indicatorY - 0.12),
              // color: Colors.red,
              child: _indicatorHidden?null:Stack(
                alignment: Alignment(-0.25, -0.3),
                children: [
                  Transform.rotate(
                    alignment: Alignment.center,
                    angle: 270 * 3.1415926535897932 / 180, // 将 45 度转换为弧度
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    _indicatorText,
                    style: TextStyle(color: Colors.grey, fontSize: 30),
                  )
                ],
              ),
            ),
            GestureDetector(
              onVerticalDragDown: (DragDownDetails details) {
                int index = getIndex(context, details.globalPosition);
                widget.indexBarCallBack!(INDEX_WORDS[index]);
                setState(() {
                  _indicatorY = 2.2/INDEX_WORDS.length * index - 1.1;
                  _indicatorText = INDEX_WORDS[index];
                  _indicatorHidden = false;
                });

                setState(() {
                  _bkColor = Color.fromRGBO(1, 1, 1, 0.5);
                  _textColor = Colors.white;
                });
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                // String str = getIndex(context, details.globalPosition);
                int index = getIndex(context, details.globalPosition);
                widget.indexBarCallBack!(INDEX_WORDS[index]);
                setState(() {
                  //2.3：根据显示的部件的高度决定
                  _indicatorY = 2.3/INDEX_WORDS.length * index - 1.1;
                  _indicatorText = INDEX_WORDS[index];
                  _indicatorHidden = false;
                });
              },
              onVerticalDragEnd: (DragEndDetails details) {
                setState(() {
                  _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
                  _textColor = Colors.black;
                  _indicatorHidden = true;
                });
              },
              child: Container(
                color: _bkColor,
                width: 20,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: _words,
                  // color: Color.fromRGBO(1, 1, 1, 0.3),
                ),
              ),
            )
          ],
        ));
  }
}

const INDEX_WORDS = [
  '🔍',
  '⭐',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
