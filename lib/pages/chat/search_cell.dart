import 'package:bottom_navigation_bar/app_config.dart';
import 'package:bottom_navigation_bar/pages/chat/chat_page.dart';
import 'package:bottom_navigation_bar/pages/chat/search_page.dart';
import 'package:flutter/material.dart';

class SearchCell extends StatelessWidget {
  const SearchCell({super.key, this.dataSource});

  final List<ChatModel>? dataSource;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SearchPage(
              dataSource: dataSource,
                )));
        print('点击了');
      },
      child: Container(
          height: 44,
          color: mainColor,
          padding: EdgeInsets.all(5),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 15,
                      color: Colors.grey,
                    ),
                    Text(
                      '搜素',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
