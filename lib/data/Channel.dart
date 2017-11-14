import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart' show DateFormat;
import './Listing.dart';

List channelsList;
const RETRY = 30;


class ChannelListingRepository implements ListingRepository{
  Future<List<Listing>> fetch(){
    return fetchListing(115);
  }
}


/// offset : [integer] defaults to 1000
///
/// returns channel = {chId, name}
///
Future fetchChannels([int offset]) async {
  var httpClient = createHttpClient();

  if(offset == null || offset == 0) offset = 10000;

  var url = "http://www.tatasky.com/tvguiderv/channels?startIndex=0&genreStr=99&subGenre=&offset=" + offset.toString();
  var response = await httpClient.read(url);

  Map responseJSON = JSON.decode(response);
  var data = parse(responseJSON["data"]);
  var heads = data.getElementsByClassName('channel-head');

  var _channels = [];

  for(var head in heads) {
    List ch = head.text.split(' - ');

    String _chId = ch.removeAt(0).toString().trim();
    String _name = (ch.reduce((value, element) => value + element)).toString().trim();

    var _channel = {
      "chId": _chId,
      "name": _name
    };
    _channels.add(_channel);
  }

  return _channels;
}

/// chId        : channel identifier
/// date        : {DateTime} defaults to current date
/// retry       : {int} defaults to 30
///
/// returns episodes : List<Listings>
///
Future<List<Listing>> fetchListing(int chId, { DateTime date, int retryCount}) async {

  if(null == retryCount) retryCount = 0;

  var httpClient = createHttpClient();
  String _dateStr;
  String _channel = await _idToChannelMapper(chId.toString());
  if(null == date) date = new DateTime.now();
  _dateStr = _convertDate(date);

  String _day = getDay(date.toString());

  String url = "http://www.tatasky.com/tvguiderv/readfiles.jsp?fileName=" +
            _dateStr + "/" + chId.toString().padLeft(5, '0') + "_event.json";

  Map headers= new Map();
  headers["Referer"] = "http://www.tatasky.com/tvguiderv/";
  headers["Accept"] = "application/json, text/javascript, */*; q=0.01";
  headers["Host"] = "www.tatasky.com";

  var response = await httpClient.read(url, headers: headers);
  var responseJSON;
  List episodes = [];

  try{
    responseJSON = JSON.decode(response);
  } catch(error) {
    if (retryCount == RETRY) {
      episodes.add(new Listing(
          chId: chId,
          channel: _channel,
          date: date,
          day: _day,
          error: error
      ));
      return episodes;
    }
    return fetchListing(chId, date: date, retryCount: retryCount + 1);
  }

  if(null != responseJSON["eventList"]) {
    for(var event in responseJSON["eventList"]) {

      double _duration = transformDuration(event["ed"]);
      String _startTime = transformTime(event["st"]);
      String _endTime = transformTime(calculateEndTime(event["st"], event["ed"], date));
      calculateEndTime(event["st"], event["ed"], date);

      Listing _episode = new Listing(
        chId: chId,
        name: event["et"],
        channel: _channel,
        duration: _duration.toStringAsFixed(2),
        startTime: _startTime,
        endTime: _endTime,
        day: _day,
        date: date
      );

      episodes.add(_episode);
    }
  }

  return episodes;
}


/// chId : channel identifier
/// date : {optional} defaults to current date
/// days : {optional} number of days from specified date
///
/// returns [Listing]
///
fetchListingsFor(int chId, {DateTime date, int days}) async {
  List<List<Listing>> _listings = [];

  if(date == null) date = new DateTime.now();

  for(var day = 0; day < days; day++) {
    _listings.add(await fetchListing(
      chId,
      date: date.add(new Duration(days: day)))
    );
  }

  return _listings;
}

/// Converts DateTime to YYYYMMDD
/// date : DateTime
///
/// returns date YYYYMMDD
///
String _convertDate(DateTime date) {
  return (
    date.year.toString() +
    date.month.toString().padLeft(2, '0') +
    date.day.toString().padLeft(2, '0')
  );
}


/// Maps channel ID to channel Name
/// chId : chId
///
/// returns String
///
_idToChannelMapper(String chId) async {
  if(channelsList == null) channelsList = await fetchChannels();
  for(Map channel in channelsList) {
    if (channel["chId"] == chId) return channel["name"];
  }
  return null;
}

///
/// Search wiki for listing, check if a match can be obtained with infobox
///
searchShow(String search, String listing) {

}


/// Transforms minutes to HH:MM format
/// minutes: int
///
/// returns Double
///
double transformDuration(int minutes) {
  if(minutes < 60)
    return minutes/ 100;
  else {
    int _hours = 0;
    while(minutes > 60) {
      minutes -= 60;
      _hours = _hours + 1;
    }
    return _hours.roundToDouble() + (minutes / 100);
  }
}

/// Transforms date to HH:MM[am/pm] format
/// time: String
///
/// returns string
///
String transformTime(String time) {
  List _list = time.split(":");
  _list.removeLast();

  String _minutes = _list.removeLast().toString();
  int _hours = int.parse(_list.removeLast());
  String _marker;

  if(_hours > 12) {
    _hours -= 12;
    _marker = "pm";
  } else if(_hours == 12)
    _marker = "pm";
  else {
    if(_hours == 0) _hours = 12;
    _marker = "am";
  }

  String _time = "$_hours:$_minutes$_marker";
  return _time;
}


/// Calculates end time of episode
///
/// startTime: String
/// duration: int
/// date: DateTime
///
/// returns string
///
String calculateEndTime(String startTime, int duration, DateTime date) {
  String _startTime = date.year.toString() + "-" +
      date.month.toString().padLeft(2, '0') + "-" +
      date.day.toString().padLeft(2, '0') + " " + startTime;

  DateTime _time = DateTime.parse(_startTime)
      .add(new Duration(minutes: duration));

  String _endTime =  _time.hour.toString().padLeft(2, '0') + ":" +
      _time.minute.toString().padLeft(2, '0') + ":" +
      _time.second.toString().padLeft(2, '0');

  return _endTime;
}

/// Returns day of the week
///
/// date: String
///
/// returns String
///
String getDay(String date) {
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  DateTime now = DateTime.parse(formatter.format(new DateTime.now()));

  List _date = date.split(" ")[0].split("-");
  DateTime _channelDate = new DateTime(int.parse(_date[0]), int.parse(_date[1]), int.parse(_date[2]));
  if(_channelDate.difference(now).inDays == 0) {
    return "Today";
  } else if(_channelDate.difference(now).inDays == 1) {
    return "Tomorrow";
  }
  List days = ["Monday", 'Tuesday', "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  return (days[_channelDate.weekday - 1]);
}