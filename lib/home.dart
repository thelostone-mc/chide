import 'package:flutter/material.dart';
import 'package:chide/ChannelListing.dart';
import 'package:chide/data/Listing.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new HomeState();
}

class HomeState extends State<Home> {

  final TextEditingController _searchController = new TextEditingController();

  Widget _buildSearchField() {
    return new Container(
      margin: const EdgeInsets.only(top: 100.0, bottom: 4.0),

      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _searchController,
              onChanged: _filterListing,
              style: new TextStyle(
                color: Colors.white,
                fontFamily: 'HelveticaNeue.ttf',
                fontWeight: FontWeight.normal,
                fontSize: 25.0
              ),
              decoration: new InputDecoration.collapsed(
                hintText: "Search All Channels.",
                hintStyle: new TextStyle(
                  color: Colors.white,
                  fontFamily: 'HelveticaNeue.ttf',
                  fontSize: 25.0,
                  fontWeight: FontWeight.w200
                )
              )
            ),
          ),
          new Container(
            child:  new ListBody(
              /// TODO: Will be empty be default, gets populates upon text change
              /// in above text field
              //children: channelNamesWidget(),
            )
          )
        ],
      )
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
      child: new ListView(
        children: [
          _buildSearchField(),
          _buildLabel("NOW"),
          new ChannelListingDummy(anotherListing),
          _buildLabel("LATER"),
          new ChannelListing(),

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

  void _filterListing(String item) {
    /// TODO: Logic to filter and update List content
    /// userInput : item -> write algorithm to give filtered possibilities
    _searchController.text = item;
  }
}

/// Retrieve channel names
//channelNamesWidget() async {
//  List<Widget> names;
//  List channels = (null == channelsList) ? await fetchChannels() : channelsList;
//
//  for(Map channel in channels)
//    names.add(new Text(channel["name"]));
//
//  return names;
//}