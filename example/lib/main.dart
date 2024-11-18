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
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isinit =
          await _truemetricsPlugin.initialize("snoonu_development_key_123") ?? "false";
      //  _truemetricsPlugin.startListening((event) {
      //   print("Truemetrics SDK State: $event");
      //   // Handle state changes here
      // });

      _truemetricsPlugin.startRecording();
      _truemetricsPlugin.startListening();

    } on PlatformException {
      isinit = "false";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
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
              )

          ]
            ),
          ),
        ),

    );
  }
}