import 'utils.dart';
import 'package:flutter/material.dart';
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 42, 173, 196)),
      ),
      home: const MyHomePage(title: 'XXH Builder'),
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

  @override
  void initState() {
    super.initState();
    platform = api.platform();
    isRelease = api.rustReleaseMode();
    hello = api.hello();
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
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
            // body:
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            children: <Widget>[
              Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/computer-vision.png',
                  ),
                  // Spacer(),
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      const SelectionArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "承接跨平台Desktop程序设计开发: Qt, Flutter，Android, Web APP；\n调研项目：图形渲染，AI",
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              "邮箱：abir5mhwei@gmail.com",
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              "微信：wei1090498448",
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 22)),
                            onPressed: () {
                              launchURL(Uri(
                                scheme: 'https',
                                host: 'github.com',
                                path: '/nooly1998/personal_webseite_builder/',
                              ));
                            },
                            child: const Text("WebSite Builder Utils"),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 22)),
                            onPressed: () {
                              launchURL(Uri(
                                scheme: 'https',
                                host: 'github.com',
                                path: '/nooly1998/opengames_utils/',
                              ));
                            },
                            child: const Text("Open Game Utils"),
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),

                  // To render the results of a Future, a FutureBuilder is used which
                  // turns a Future into an AsyncSnapshot, which can be used to
                  // extract the error state, the loading state and the data if
                  // available.
                  //
                  // Here, the generic type that the FutureBuilder manages is
                  // explicitly named, because if omitted the snapshot will have the
                  // type of AsyncSnapshot<Object?>.
                  FutureBuilder<List<dynamic>>(
                    // We await two unrelated futures here, so the type has to be
                    // List<dynamic>.
                    future: Future.wait([platform, isRelease, hello]),
                    builder: (context, snap) {
                      final style = Theme.of(context).textTheme.headlineMedium;
                      if (snap.error != null) {
                        // An error has been encountered, so give an appropriate response and
                        // pass the error details to an unobstructive tooltip.
                        debugPrint(snap.error.toString());
                        return Tooltip(
                          message: snap.error.toString(),
                          child: Text('Unknown OS', style: style),
                        );
                      }

                      // Guard return here, the data is not ready yet.
                      final data = snap.data;
                      if (data == null)
                        return const CircularProgressIndicator();

                      // Finally, retrieve the data expected in the same order provided
                      // to the FutureBuilder.future.
                      final Platform platform = data[0];
                      final release = data[1] ? 'Release' : 'Debug';
                      final text = const {
                            Platform.Android: 'Android',
                            Platform.Ios: 'iOS',
                            Platform.MacApple: 'MacOS with Apple Silicon',
                            Platform.MacIntel: 'MacOS',
                            Platform.Windows: 'Windows',
                            Platform.Unix: 'Unix',
                            Platform.Wasm: 'the Web',
                          }[platform] ??
                          'Unknown OS';
                      final hell = data[2];
                      return Text('$text ($release) \n $hell', style: style);
                    },
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
