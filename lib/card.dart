import 'package:flutter/material.dart';

Widget buildCard(Map input, {String alarm}) {
  BorderRadius _borderRadius;
  EdgeInsetsGeometry _margin;

  if(null == alarm) {
    _borderRadius = const BorderRadius.all(const Radius.circular(4.0));
    _margin = const EdgeInsets.symmetric(vertical: 5.0);
  } else {
    _borderRadius = const BorderRadius.only(topLeft: const Radius.circular(4.0), topRight: const Radius.circular(4.0));
    _margin =  const EdgeInsets.only(top: 5.0);
  }

  List<Widget> _widget = <Widget>[
    new Container(
      margin: _margin,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: _borderRadius,
        boxShadow: <BoxShadow> [
          new BoxShadow (
            color: const Color.fromRGBO(0, 0, 0, 0.19),
            offset: new Offset(0.0, 4.0),
            blurRadius: 6.0,
          ),
          new BoxShadow (
            color: const Color.fromRGBO(0, 0, 0, 0.23),
            offset: new Offset(0.0, 4.0),
            blurRadius: 6.0,
          )
        ]
      ),
      child: new Container(
        margin: const EdgeInsets.all(12.0),
        child: new Column(
          children: _buildChannelCard(input)
        )
      )
    )
  ];

  if(null != alarm) {
    _widget.add(_buildAlarmBox());
  }

  return new Column(children: _widget);
}

List<Widget> _buildChannelCard(Map input) {
  return <Widget>[
    // Time
    new Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: new Row(
        children: <Widget>[
          new Container(
            child: _buildLabelTime(input["day"]),
          ),
          new Container(
            child: _buildLabelTime(".", weight: FontWeight.bold),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          new Container(
            child: _buildLabelTime(input["startTime"] +  "-" + input["endTime"]),
          )
        ]
      ),
    ),
    // Listing
    new Row(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(bottom: 2.0),
          child: new Text(input["name"], style: new TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14.0
          )),
        ),
      ],
    ),
    // Channel & Duration
    new Column(
      children: <Widget>[
        _buildLabelInfo(Icons.tv, "Channel: " + input["channel"]),
        _buildLabelInfo(Icons.access_time, "Duration: " + input["duration"])
      ],
    )
  ];
}

Widget _buildLabelTime(String text, {FontWeight weight}) {
  weight = (weight != null) ? weight : FontWeight.w400;
  return new Text(text, style: new TextStyle(
    fontSize: 16.0,
    fontWeight: weight,
    color: new Color.fromRGBO(18, 46, 70, 1.0)
  ));
}

Widget _buildLabelInfo(IconData iconData, String text) {
  return new Container(
    margin: const EdgeInsets.only(top: 4.0),
    child: new Opacity(
      opacity: 0.95,
      child: new Row(
        children: <Widget>[
          new Icon(iconData, size: 12.0),
          new Container(
            margin: const EdgeInsets.only(left: 6.0),
            child: new Text(text, style: new TextStyle(
              fontSize: 12.0
            ))
          )
        ]
      )
    )
  );
}

Widget _buildAlarmBox() {
  return new Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    decoration: new BoxDecoration(
      borderRadius: const BorderRadius.only(bottomLeft: const Radius.circular(4.0), bottomRight: const Radius.circular(4.0)),
      color: new Color.fromRGBO(232, 249, 239, 1.0),
      boxShadow: <BoxShadow> [
        new BoxShadow (
          color: const Color.fromRGBO(0, 0, 0, 0.19),
          offset: new Offset(0.0, 4.0),
          blurRadius: 6.0,
        ),
        new BoxShadow (
          color: const Color.fromRGBO(0, 0, 0, 0.23),
          offset: new Offset(0.0, 4.0),
          blurRadius: 6.0,
        )
      ],
    ),
    child: new Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
      child: new Row(
        children: <Widget>[
          new Opacity(
            opacity: 0.70,
            child: new Text("STARTS IN", style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10.0,
            ))
          ),
          new Text("02h : 30m : 60s", textAlign: TextAlign.right, style: new TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w700,
            fontSize: 10.0,
          ))
        ],
      ),
    )
  );
}