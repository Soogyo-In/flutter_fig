import 'dart:js_interop';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _selectionIds = [];

  @override
  void initState() {
    super.initState();
    onMessage = _onMessage.toJS;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Fig')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _onAddRectangleButtonPressed,
              child: const Text('Add Ramdom Rectangle'),
            ),
          ),
          ElevatedButton(
            onPressed: _onGetSelectionButtonPressed,
            child: const Text('Get Selection'),
          ),
          if (_selectionIds.isNotEmpty) Text(_selectionIds.toString()),
        ],
      ),
    );
  }

  void _onAddRectangleButtonPressed() {
    final random = Random();

    postMessage(
      'drawRectangle',
      RectangleNode(
        height: max(1, random.nextInt(300)),
        width: max(1, random.nextInt(300)),
        x: random.nextInt(300),
        y: random.nextInt(300),
        fills: [
          SolidPaint(
            type: 'SOLID',
            color: RGB(
              r: random.nextInt(256) / 256,
              g: random.nextInt(256) / 256,
              b: random.nextInt(256) / 256,
            ),
          ),
        ].toJS,
      ),
    );
  }

  void _onGetSelectionButtonPressed() => postMessage('getSelection');

  void _onMessage(Message message) {
    if (message.method == 'getSelection') {
      final selection = message.data as JSArray<RectangleNode>;
      setState(() {
        _selectionIds = selection.toDart.map((e) => e.id).toList();
      });
    }
  }
}

@JS()
external void postMessage(String method, [JSObject? data]);

@JS()
external set onMessage(JSFunction value);

extension type Message._(JSObject _) implements JSObject {
  external String get method;

  external JSObject get data;
}

extension type RectangleNode._(JSObject _) implements JSObject {
  external RectangleNode({
    num x,
    num y,
    num width,
    num height,
    JSArray<SolidPaint> fills,
  });

  external String get id;

  external num get x;

  external num get y;

  external num get width;

  external num get height;

  external JSArray<SolidPaint> get fills;
}

extension type SolidPaint._(JSObject _) implements JSObject {
  external SolidPaint({String type, RGB color});

  external String get type;

  external RGB get color;
}

extension type RGB._(JSObject _) implements JSObject {
  external RGB({num r, num g, num b});

  external num get r;

  external num get g;

  external num get b;
}
