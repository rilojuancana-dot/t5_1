import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t5_1/model/information.dart';
import 'package:t5_1/model/status.dart';

class FavStation extends StatefulWidget {
    final Status status;
    final InformationStation information;
    final List<Status> statusData;
    final List<InformationStation> informationData;

    const FavStation({
      super.key, 
      required this.status, 
      required this.information, 
      required this.statusData, 
      required this.informationData
    });
  
    @override
    _FavStationState createState() => _FavStationState();
}

class _FavStationState extends State<FavStation> {
  
  @override
  Widget build(BuildContext context) {
      
    return Padding(padding:  EdgeInsets.all(16),
      child: Column(
        children: [
          
          LastUpdated(),
          SizedBox(height: 16),
          AvailableBikesGraph(),
          SizedBox(height: 16),
          FavStationDetails(),
          SizedBox(height: 16),
          StationsList(),
          
        ],
      ),
    );
  }

  Widget LastUpdated() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Last Updated: '),
          Text('TODO'),
        ],
      ),
    );
  }

  Widget AvailableBikesGraph() {

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              
              value: widget.status.vehicleTypesAvailable.first.count.toDouble(),
              color: Colors.red,
              title: widget.status.vehicleTypesAvailable.first.bikeType.name,
            ),
            PieChartSectionData(
              value: widget.status.vehicleTypesAvailable[1].count.toDouble(),
              color: Colors.blue,
              title: widget.status.vehicleTypesAvailable[1].bikeType.name,
            ),
            PieChartSectionData(
              value: widget.status.vehicleTypesAvailable[2].count.toDouble(),
              color: Colors.green,
              title: widget.status.vehicleTypesAvailable[2].bikeType.name,
            ),
          ],
        ),
      )
    );
  }

  Widget FavStationDetails() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Text('Estación: ${widget.status.id} ${widget.information.name}'),
          Text("|"),

          Text("Dirección: ${widget.information.adress}"),
          Text("|"),

          Text('Actualizado por última vez: ${widget.status.lastReported}'),
          Text("|"),

          Text('Hay bicis disponibles: ${widget.status.isRenting ? "Sí" : "No"}'),
          Text("|"),

          Text('Bicis disponibles: ${widget.status.bikesAvailable}'),
          Text("|"),

          Text('Estaciones disponibles: ${widget.status.docksAvailable}'),
          Text("|"),

          Text("Estado: ${widget.status.status.name}"),
        ],
      ),
    );
  }

  Widget StationsList() {
    return Expanded(
      
      child: Stack(
        
        children: [
          
          Container(
            color: Colors.lightBlue.withAlpha(100),
          ),
          ListView.builder(
            itemCount: widget.informationData.length,
            itemBuilder: (context, index) {
              final info = widget.informationData[index];
              final status = widget.statusData.firstWhere((s) => s.id == info.station_id, orElse: () => 
                Status(id: info.station_id, isRenting: false, bikesAvailable: 0, docksAvailable: 0, 
                lastReported: 0, status: StatusEnum.UNKNOWN, vehicleTypesAvailable: [],
                bikesDisabled: 0, docksDisabled: 0, isInstalled: false, isReturning: false));
              
              return ListTile(
                title: Text('${info.name}', textAlign: TextAlign.center,),
                subtitle: Text('Bicis disponibles: ${status.bikesAvailable}',textAlign: TextAlign.center),
              );
            },
          )
        ],
      )
    );
  }
}
