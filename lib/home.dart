import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new HomeState();
}

class HomeState extends State<Home> {

  final TextEditingController _searchController = new TextEditingController();

  Widget _buildSearchField() {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new TextField(
        controller: _searchController,
        onSubmitted: _submit,
        decoration: new InputDecoration.collapsed(hintText: "channel / show"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("channels"),
      ),
      body: _buildSearchField(),
    );
  }

  void _submit(String text) {
    _searchController.clear();
  }
}

