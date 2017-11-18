import 'package:flutter/material.dart';
import 'package:chide/data/Listing.dart';
import 'package:chide/ListingCard.dart';
import './module/ChannelListPresenter.dart';

class ChannelListing extends StatefulWidget {

  @override
  ChannelListingState createState() => new ChannelListingState();
}

class ChannelListingState extends State<ChannelListing> implements ChannelListViewContract {

  ChannelListPresenter _presenter;
  List<Listing> _listings;

  ChannelListingState() {
    _presenter = new ChannelListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadChannelListing();
  }

  @override
  void onComplete(List<Listing> listings) {
    setState(() {
      _listings = listings;
    });
  }

  @override
  void onError() {
    // TODO: error handling when data is NA
  }

  @override
  Widget build(BuildContext context) {
    if(null != _listings) {
      return new Flex(
        children: _buildChannelListing(),
        direction: Axis.vertical,
      );
    } else {
      return new Center(
        child: new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new CircularProgressIndicator()
        )
      );
    }

//    return new Flex(
//      children: _buildChannelListing(),
//      direction: Axis.vertical,
//    );
  }

  List <ListingCard> _buildChannelListing() {
    if(null == _listings) {
      print("List is empty!");
      _listings = anotherListing;
    }
    return _listings.map((listing) =>
      new ListingCard(listing)).toList();
  }
}

/// Dummy class to show card with alarm
///
class ChannelListingDummy extends StatelessWidget {
  final List<Listing> _listings;
  ChannelListingDummy(this._listings);

  @override
  Widget build(BuildContext context) {
    return new Flex(
      children: _buildChannelListing(),
      direction: Axis.vertical,
    );
  }

  List <ListingCard> _buildChannelListing() {
    return _listings.map((listing) =>
    new ListingCard(listing)).toList();
  }
}