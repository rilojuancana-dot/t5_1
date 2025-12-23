import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t5_1/model/status.dart';

class FavStation extends StatefulWidget {
    const FavStation({Key? key, required Status status, required int lastUpdated});
    
      get lastUpdated => lastUpdated;
      get status => status;
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
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: widget.status.bikesAvailable.toDouble(),
            color: Colors.green,
            title: 'Available Bikes',
          ),
          PieChartSectionData(
            value: widget.status.docksAvailable.toDouble(),
            color: Colors.red,
            title: 'Available Docks',
          ),
        ],
      ),
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
