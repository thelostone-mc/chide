import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parse;

/// offset : [integer] defaults to 1000
///
/// returns channel = {chId, name}
///
fetchChannels([int offset]) async {
  var httpClient = createHttpClient();

  if(offset == null || offset == 0) offset = 10000;

  var url = "http://www.tatasky.com/tvguiderv/channels?startIndex=1&genreStr=99&subGenre=&offset=" + offset.toString();
  var response = await httpClient.read(url);

  Map responseJSON = JSON.decode(response);
  var data = parse(responseJSON["data"]);
  var heads = data.getElementsByClassName('channel-head');

  var channels = [];

  for(var head in heads) {
    List ch = head.text.split(' - ');

    var chId = ch.removeAt(0).toString().trim();
    var name = (ch.reduce((value, element) => value + element)).toString().trim();

    var channel = {
      "chId": chId,
      "name": name
    };
    channels.add(channel);
  }

  return channels;
}


/// chId : channel identifier
/// date : {optional} defaults to current date
///
/// returns listing {
///  chId,
///  date,
///  episodes [name, startTime, duration]
/// }
///
fetchListing(int chId, [DateTime date]) async {
  var httpClient = createHttpClient();
  var dateStr = "";

  if(null == date) date = new DateTime.now();
  dateStr = _convertDate(date);

  var url = "http://www.tatasky.com/tvguiderv/readfiles.jsp?fileName=" +
            dateStr + "/00" + chId.toString() + "_event.json";

  var response = await httpClient.read(url);

  var responseJSON = JSON.decode(response);
  var episodes = [];

  if(null != responseJSON["eventList"]) {
    for(var event in responseJSON["eventList"]) {
      var episode = {
        "name": event["et"],
        "startTime": event["st"],
        "duration": event["ed"]
      };
      episodes.add(episode);
    }
  }

  var listing = {
    "chId": chId,
    "date": date,
    "episodes": episodes
  };

  return listing;
}


/// chId : channel identifier
/// date : {optional} defaults to current date
/// days : {optional} number of days from specified date
///
/// returns [listing]
///
fetchListingsFor(int chId, {DateTime date, int days}) async {
  List<String> listings = [];

  if(date == null) date = new DateTime.now();

  for(var day = 0; day < days; day++) {
    listings.add(await fetchListing(chId, date.add(new Duration(days: day))));
  }

  return listings;
}

/// Converts DateTime to YYYYMMDD
/// date : DateTime
///
/// returns date YYYYMMDD
///
String _convertDate(DateTime date) {
  return (date.year.toString() + date.month.toString() + date.day.toString());
}

///
/// Search wiki for listing, check if a match can be obtained with infobox
///
searchShow(String search, String listing) {

}