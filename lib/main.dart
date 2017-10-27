import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(new Chide());
}

class Chide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "chide",
      home: new Home(),
    );
  }
}
