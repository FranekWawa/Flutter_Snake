import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double timerSpeed = 200;

  double getSpeed() {
    return timerSpeed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Slider(
              value: timerSpeed,
              min: 50,
              max: 300,
              divisions: 50,
              label: timerSpeed.round().toString(),
              onChanged: (double value) {
                setState(() {
                  timerSpeed = value;
                });
              },
            ),
            RaisedButton(
                onPressed: () => Navigator.pop(context, timerSpeed.round()))
          ],
        ),
      ),
    );
  }
}
