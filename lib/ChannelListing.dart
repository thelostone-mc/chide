import 'package:flutter/material.dart';
import 'package:chide/data/Listing.dart';
import 'ListingCard.dart';

class ChannelListing extends StatelessWidget {
  final List<Listing> _listings;
  ChannelListing(this._listings);

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