import 'package:flutter/material.dart';
//主题色
const Color mainColor = Color.fromRGBO(220, 220, 220, 1.0);
//屏幕尺寸 非常量标识符使用小驼峰命名法命名(首字母消协)。
Size screenSize(BuildContext context) => MediaQuery.of(context).size;