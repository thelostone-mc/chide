import '../lib/channels.dart';
import 'package:intl/intl.dart' show DateFormat;

main() async {
  await testChannels();
  testTransformTime();
  testTransformDuration();
  testGetDay();
}

testChannels() async {
  DateTime _nextDay = new DateTime.now().add(new Duration(days: 3));

  var channelListings = await fetchListingsFor(115, days: 3);
  assert(null != channelListings);
  //print(channelListings);

  var channelListing = await fetchListing(115);
  assert(null != channelListing);
  //print(channelListing);


  var nextDaysChannelListing = await fetchListing(114, date: _nextDay);
  assert(null != nextDaysChannelListing);
  //print(nextDaysChannelListing);

  var channels = await fetchChannels();
  assert(null != channels);
}

testTransformTime() {
  assert("12:15am" == transformTime("00:15:00"));
  assert("12:15pm" == transformTime("12:15:00"));
  assert("6:15pm" == transformTime("18:15:00"));
}

testTransformDuration() {
  assert(3.50 == transformDuration(230));
}

testGetDay() {
  var _formatter = new DateFormat('yyyy-MM-dd');
  DateTime _now = new DateTime.now();
  assert("Today" == getDay(_formatter.format(_now)));

  DateTime _nextDay = new DateTime.now().add(new Duration(days: 1));
  assert("Tomorrow" == getDay(_formatter.format(_nextDay).toString()));

//  DateTime _random = new DateTime.now().add(new Duration(days: 2));
//  print(getDay(_formatter.format(_random)));
}

Map _sampleInput = {
  "name": "Game Of Thrones",
  "channel": "Star Movies HD",
  "duration": "3.50",
  "startTime": "12:30pm",
  "endTime": "4:00pm",
  "day": "Today/Tom/Mon/Tue/..Sunday"
};
