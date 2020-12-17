import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wechat_web_login_plugin/wechat_web_login_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String info = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      // platformVersion = await WechatWebLoginPlugin.getWechatInfo;
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      // info = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('Running on: $info\n'),
            FloatingActionButton(
                onPressed: () async {
                  try {
                    info = await WechatWebLoginPlugin.getWechatInfo("");
                  } on PlatformException {
                    info ="失败了";
                  }
                  setState(() {
                  });
                },
              child: Text("跳转微信"),
            ),
          ],
        )
        ),
      );
  }
}
