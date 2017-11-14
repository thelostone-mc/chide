import 'dart:async';

abstract class ListingRepository {
  Future<List<Listing>> fetch();
}

class Listing {
  int chId;
  bool alarm;
  String name;
  String channel;
  String duration;
  String startTime;
  String endTime;
  String day;
  String error;
  DateTime date;

  Listing({
    this.chId,
    this.name,
    this.channel,
    this.duration,
    this.startTime,
    this.endTime,
    this.day,
    this.alarm,
    this.date,
    this.error
  });

}

/// exception: fetch() fails
class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  @override
  String toString() {
    return "fetchData: " + _message;
  }
}


/// Sample Data
var listingData = [
  new Listing(
    name: "Game Of Thrones",
    channel: "Star Movies HD",
    duration: "3.50",
    startTime: "12:30pm",
    endTime: "4:00pm",
    day: "Today"
  ),
  new Listing(
    name: "Rick And Morty",
    channel: "Star Movies HD",
    duration: ".30",
    startTime: "3:30pm",
    endTime: "4:00pm",
    day: "Today"
  ),
];

var anotherListing = [
  new Listing(
    name: "Rick And Morty",
    channel: "Star Movies HD",
    duration: ".30",
    startTime: "3:30pm",
    endTime: "4:00pm",
    day: "Today",
    alarm: true
  )
];