import '../lib/channels.dart';


main() async{
  await testChannels();
}

testChannels() async {
  var channelListings = await fetchListingsFor(115, days: 2);
  var channelListing = await fetchListing(115);
  var channels = await fetchChannels();
  print(channels);
  assert(null != channelListings);
  assert(null != channelListing);
  assert(null != channels);
}