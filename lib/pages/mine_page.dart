import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1.0),

        title: const Text('我的'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('我的'),
      ),
    );
  }
}
