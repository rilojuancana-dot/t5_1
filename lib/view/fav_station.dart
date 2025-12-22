import 'package:flutter/material.dart';
import 'package:t5_1/model/status.dart';

class FavStation extends StatefulWidget {
    const FavStation({Key? key, required Status status, required int lastUpdated});
    
      get lastUpdated => lastUpdated;
    @override
    _FavStationState createState() => _FavStationState();
}

class _FavStationState extends State<FavStation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LastUpdated(),
        AvailableBikesGraph(),
        FavStationDetails(),
        StationsList()
      ],
    );
  }

  Widget LastUpdated() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Last Updated: '),
          Text('${widget.lastUpdated}'),
        ],
      ),
    );
  }

  Widget AvailableBikesGraph() {
    return Container(
      child: Text('Available Bikes Graph'),
    );
  }

  Widget FavStationDetails() {
    return Container(
      child: Text('Fav Station Details'),
    );
  }

  Widget StationsList() {
    return Container(
      child: Text('Stations List'),
    );
  }
}
