class Listing {
  String name;
  String channel;
  String duration;
  String startTime;
  String endTime;
  String day;
  bool alarm;

  Listing({
    this.name,
    this.channel,
    this.duration,
    this.startTime,
    this.endTime,
    this.day,
    this.alarm
  });

}

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