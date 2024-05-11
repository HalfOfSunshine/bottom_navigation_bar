import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverCell extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String imageName;
  final String? subImageName;

  const DiscoverCell({
    required this.title,
    this.subTitle,
    required this.imageName,
    this.subImageName,
  }):assert(title != null,"title不能为空"),assert(imageName != null,"imageName不能为空");

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  image: AssetImage(imageName),
                  width: 20,
                ),
                //间隙
                const SizedBox(
                  width: 15,
                ),
                //title
                Text(title),
              ],
            ),
          ),
          //right
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                //subtitle
                subTitle != null ? Text(subTitle!) : const Text(""),

                //subImage
                subImageName != null ? Image.asset(subImageName!) : Container(),
                //箭头
                const Image(
                  image: AssetImage("images/ad_icon3.png"),
                  width: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
