import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/core.dart';
import 'ffi.dart' if (dart.library.html) 'ffi_web.dart';
// import 'core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XXH Builder',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // colorSchemeSeed: const Color.fromARGB(255, 42, 147, 196),
        // primarySwatch: Colors.blue,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 42, 173, 196)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // These futures belong to the state and are only initialized once,
  // in the initState method.
  late Future<Platform> platform;
  late Future<bool> isRelease;
  late Future<String> hello;
  late Future<List<String>> pages;
  @override
  void initState() {
    super.initState();
    platform = api.platform();
    isRelease = api.rustReleaseMode();
    pages = api.pages();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 204, 51, 128),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          drawer: lDrawer(pages, context),
          body: Stack(children: [
            Positioned(
              left: 0,
              top: 0,
              child: Column(
                children: [
                  FilledButton(
                    onPressed: () {},
                    child: const Text("Data"),
                  ),
                ],
              ),
            ),
            Positioned(
                left: 60,
                child: Container(
                  child: SingleChildScrollView(
                    child: const Text("添加组件"),
                  ),
                )),
            Positioned(
                right: 0,
                width: 100,
                height: 300,
                child: ListView(
                  children: [Text("组件1")],
                ))
          ])
          // body: SingleChildScrollView(
          //   child: Container(
          //     child: Text("Tab1 content"),
          //   ),
          // )),
          ),
    );
  }
}
