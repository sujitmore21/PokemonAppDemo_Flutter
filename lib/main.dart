import 'package:flutter/material.dart';




void main() => runApp(
    MaterialApp(
  title: "Poke App",
  theme: ThemeData(primarySwatch: Colors.teal),
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
      ),
    );
  }
}

