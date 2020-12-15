
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_old/flutter_plugin_old.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  String getTitle = "null";

  String getPassMessage;

  String message;
  String info;

  Map <dynamic,dynamic> mapPass ;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPluginOld.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    try {
      getTitle = await FlutterPluginOld.changePageTitle;
    } on PlatformException {
      getTitle = 'Failed to get title';
    }
    // try {
    //     getPassMessage = await FlutterPluginOld.getAndPushValue("射了一斤");
    // } on PlatformException {
    //     getPassMessage = 'Failed to get message';
    // }

    try {
      message = await FlutterPluginOld.getAndPushValue("姜贞羽吃了我的精子");
    } on PlatformException {

    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(getTitle),
        ),
        body: Column(
          children:[
            FloatingActionButton (
              onPressed: () async{
                try {
                  message = await FlutterPluginOld.getAndPushValue("姜贞羽吃了我的精子");
                } on PlatformException {
                  message ="失败了";
                }
                setState(() {
                });
              },
              child: Text("传递数据"),
            ),

            FloatingActionButton (
              onPressed: () async{
                FlutterPluginOld();
                setState(() {
                });
              },
              child: Text("dart监听原生方法"),
            ),

        //

        Text('Running on: $_platformVersion\n'),
            getPassMessage != null?Text(getPassMessage):SizedBox.shrink(),
            message != null?Text("$message       $message"):SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
