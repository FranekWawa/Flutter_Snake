import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'logic.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Settings settings = new Settings();

  Logic logic = new Logic();

  int speed = 200;

  void setTimer() {
    logic.startGame();
    var duration = Duration(milliseconds: speed);
    if (logic.timer == null || !logic.timer.isActive) {
      logic.timer = Timer.periodic(duration, (Timer timer) {
        setState(() {
          logic.moveSnake();
        });
      });
    }
  }

  getSpeed(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings()),
    );
    setState(() {
      speed = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: GestureDetector(
          onTap: () => getSpeed(context),
          child: Icon(
            Icons.settings, // add custom icons also
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: GestureDetector(
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 10,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    children: List.generate(150, (index) {
                      return Material(
                        color: logic.color(index),
                      );
                    }),
                  ),
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx < 0) {
                      logic.changeDirection("left");
                    }
                    if (details.delta.dx > 0) {
                      logic.changeDirection("right");
                    }
                  },
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0) {
                      logic.changeDirection("down");
                    }
                    if (details.delta.dy < 0) {
                      logic.changeDirection("up");
                    }
                  }),
            ),
            new RaisedButton(
              onPressed: setTimer,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
