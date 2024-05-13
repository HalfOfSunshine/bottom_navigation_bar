import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverCell extends StatefulWidget {
  final String title;
  final String? subTitle;
  final String imageName;
  final String? subImageName;
  final GestureTapCallback? onTap;

  const DiscoverCell({
    super.key,
    required this.title,
    this.subTitle,
    required this.imageName,
    this.subImageName,
    this.onTap,
  });

  @override
  State<DiscoverCell> createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  Color _stateColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tapAction $widget.title');
        widget.onTap?.call();
        setState(() {
          _stateColor = Colors.grey;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _stateColor = Colors.white;
        });
      },
      onTapCancel: () {
        _stateColor = Colors.white;
      },
      child: Container(
        color: _stateColor,
        //固定高度，高度没固定之前由padding以及内部组件撑起来（尤其是图片）
        height: 45,
        child: Row(
          //主轴是spaceBetween
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //left
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  //图标
                  Image(
                    image: AssetImage(widget.imageName),
                    width: 20,
                  ),
                  //间隙
                  const SizedBox(
                    width: 15,
                  ),
                  //title
                  Text(widget.title),
                ],
              ),
            ),
            //right
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  //subtitle
                  widget.subTitle != null
                      ? Text(widget.subTitle!)
                      : const Text(""),

                  //subImage width: 15避免被图片撑大
                  widget.subImageName != null
                      ? Image.asset(
                          widget.subImageName!,
                          width: 15,
                        )
                      : Container(),
                  //箭头
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
