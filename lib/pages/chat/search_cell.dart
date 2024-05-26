import 'package:bottom_navigation_bar/app_config.dart';
import 'package:flutter/material.dart';

class SearchCell extends StatelessWidget {
  const SearchCell({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
