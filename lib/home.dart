import 'package:flutter/material.dart';
import './card.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new HomeState();
}

class HomeState extends State<Home> {

  final TextEditingController _searchController = new TextEditingController();

  Widget _buildSearchField() {
    return new Container(
      margin: const EdgeInsets.only(top: 100.0, bottom: 4.0),

      child: new TextField(
        controller: _searchController,
        style: new TextStyle(
          color: Colors.white,
          fontFamily: 'HelveticaNeue.ttf',
          fontWeight: FontWeight.normal,
          fontSize: 25.0
        ),
        decoration: new InputDecoration.collapsed(
          hintText: "All Channels.",
          hintStyle: new TextStyle(
            color: Colors.white,
            fontFamily: 'HelveticaNeue.ttf',
            fontSize: 25.0,
            fontWeight: FontWeight.w200
          )
        )
      ),
    );
  }

  Widget _buildLabel(String msg) {
    return new Container(
      margin: const EdgeInsets.only(top: 30.0, bottom: 4.0),
      child: new Opacity(
        opacity: 0.50,
        child: new Text(msg, style: new TextStyle(
          color: Colors.white,
          fontFamily: 'HelveticaNeue.ttf',
          fontSize: 11.0,
        )),
      ),
    );
  }

  Widget _buildScreen() {
    return new Container(
      margin: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(),
          _buildLabel("NOW"),
          buildCard(_sampleInput, alarm: "true"),
          _buildLabel("LATER"),
          buildCard(_sampleInput),
          buildCard(_sampleInput)
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildScreen(),
      backgroundColor: new Color.fromRGBO(48, 136, 244, 1.0)
    );
  }
}

Map _sampleInput = {
  "name": "Game Of Thrones",
  "channel": "Star Movies HD",
  "duration": "3.50",
  "startTime": "12:30pm",
  "endTime": "4:00pm",
  "day": "Today"
};


