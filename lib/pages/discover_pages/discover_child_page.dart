import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverChildPage extends StatelessWidget {
  final String ? title;

  const DiscoverChildPage({super.key,this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title != null?title!:'一个发现的子页面'),
      ),
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}
