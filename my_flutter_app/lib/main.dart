import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:demo_native_app/demo_native_app.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Use Flutter Dependency Demo Page'),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hey Purva',
            ),
         ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await AlertBoxPJ.showCustomAlertBox(
              context: context,
              willDisplayWidget: Container(
                child: const Text('You have came from native app. This app is using package which is created by PJ'),
              ),
          buttonName: "123");
        },
        tooltip: 'Show Custom Alert Box',
        child: const Text("check"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String _inputText = "";
  TextEditingController inputtextField = TextEditingController();
  static const platform = const MethodChannel('com.souvikbiswas.tipsy/result');

  Future<void> _receiveFromHost(MethodCall call) async {
    var jData;

    try {
      if (call.method == "getCalculatedResult") {
        final String data = call.arguments;
        jData = await jsonDecode(data);
      }
    } on PlatformException catch (error) {
      print(error);
    }

    setState(() {
      inputtextField.text = jData['message'];

    });
  }

  @override
  void initState() {
    platform.setMethodCallHandler(_receiveFromHost);

    super.initState();
  }


  // void _processText() {
  //   setState(() {
  //     _inputText = inputtextField.text;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: inputtextField,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter some text'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '$_inputText',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          // RaisedButton(
          //   onPressed: _processText,
          //   child: Text('Process Text'),
          // )
          ElevatedButton(
            //onPressed: _processText,
            onPressed: (){
              AlertBoxPJ.showCustomAlertBox(
                  context: context,
                  willDisplayWidget: Container(
                    child: Text(inputtextField.text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.start),
                  ),
                  buttonName: "ok"
              );
            },
            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
            style: ElevatedButton.styleFrom(
                elevation: 20.0,
                textStyle: const TextStyle(color: Colors.white)),
            child: const Text('Check text', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800), textAlign: TextAlign.start),
          )
         
        ],
      ),

    );
  }
}