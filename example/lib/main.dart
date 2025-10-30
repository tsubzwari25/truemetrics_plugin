import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:truemetrics/truemetrics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _isInit = "false";
  final _truemetricsPlugin = Truemetrics();

  @override
  void initState() {
    super.initState();
    initPlatformState();

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String isinit;

    try {
      isinit =
          await _truemetricsPlugin.initialize("development_key_12") ?? "false";


      await _truemetricsPlugin.startRecording();
      _truemetricsPlugin.startListening();

    } on PlatformException {
      isinit = "false";
    }

    if (!mounted) return;

    setState(() {
      _isInit = isinit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: Text('Running on: $_isInit\n'),
              ),
              InkWell(
                splashColor: Colors.amberAccent.shade100,
                onTap: (){
                  _truemetricsPlugin.startRecording();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color:Colors.amber,
                  child: Center(child: Text("Start Recording")),
                ),
              ), InkWell(
                splashColor: Colors.amberAccent.shade100,
                onTap: (){
                  _truemetricsPlugin.stopRecording();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color:Colors.amber,
                  child: Center(child: Text("Stop Recording")),
                ),
              ),InkWell(
                splashColor: Colors.amberAccent.shade100,
                onTap: (){
                  _truemetricsPlugin.initialize("development");
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color:Colors.amber,
                  child: Center(child: Text(" init")),
                ),
              ),

              InkWell(
                splashColor: Colors.amberAccent.shade100,
                onTap: (){
                  _truemetricsPlugin.deinit();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color:Colors.amber,
                  child: Center(child: Text("De init")),
                ),
              ),

              InkWell(
                splashColor: Colors.amberAccent.shade100,
                onTap: (){
                  _truemetricsPlugin.logMetaData({"OrderId": "12345"});
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color:Colors.amber,
                  child: Center(child: Text("Log Data")),
                ),
              )

          ]
            ),
          ),
        ),

    );
  }
}
