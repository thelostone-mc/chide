import 'package:chide/data/Channel.dart';
import 'package:chide/data/Listing.dart';

abstract class ChannelListViewContract {
  void onComplete(List<Listing> listing);
  void onError();
}

class ChannelListPresenter {
  ChannelListingRepository _repository;
  ChannelListViewContract _view;

  ChannelListPresenter(this._view) {
    _repository = new ChannelListingRepository();
  }

  void loadChannelListing() {
    assert(_view != null);
    _repository.fetch()
      .then((listings) => _view.onComplete(listings))
      .catchError((error) {
        print("loadChannelListing: " + error);
        _view.onError();
      });
  }
}