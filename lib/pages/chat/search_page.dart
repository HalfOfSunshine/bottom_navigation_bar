import 'package:bottom_navigation_bar/app_config.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: SearchBar(),
      //   backgroundColor: mainColor,
      // ),
      body: Column(
        children: [
          SearchBar(),
          Expanded(
              flex: 1,
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Text('data');
                    }),
              ))
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
                width: screenSize(context).width-40,
                height: 34,
                color: Colors.yellow,
              ),
              Text('取消'),
            ],
          ),
        )
      ],
    );
  }
}
