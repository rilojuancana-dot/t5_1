import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t5_1/model/information.dart';
import 'package:t5_1/model/status.dart';
import 'package:t5_1/view/fav_station.dart';

class StationDetail extends StatelessWidget{
  int last_updated;
  Status status;
  InformationStation information;
  final List<Status> statusData;
  final List<InformationStation> informationData;

  StationDetail({
    super.key, 
    required this.last_updated,
    required this.status, 
    required this.information, 
    required this.statusData, 
    required this.informationData
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Icon(Icons.arrow_back_rounded)),
        title: Text("Detalle de la estación"),
      ),
      body: Padding(padding:  EdgeInsets.all(16),
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
    ),
    );
  }

  Widget LastUpdated() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Last Updated: '),
          Text('$last_updated'),
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
              value: status.vehicleTypesAvailable.first.count.toDouble(),
              color: Colors.red,
              title: status.vehicleTypesAvailable.first.bikeType.name,
            ),
            PieChartSectionData(
              value: status.vehicleTypesAvailable[1].count.toDouble(),
              color: Colors.blue,
              title: status.vehicleTypesAvailable[1].bikeType.name,
            ),
            PieChartSectionData(
              value: status.vehicleTypesAvailable[2].count.toDouble(),
              color: Colors.green,
              title: status.vehicleTypesAvailable[2].bikeType.name,
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
          Text('Estación: ${status.id} ${information.name}'),
          Text("|"),

          Text("Dirección: ${information.adress}"),
          Text("|"),

          Text('Actualizado por última vez: ${status.lastReported}'),
          Text("|"),

          Text('Hay bicis disponibles: ${status.isRenting ? "Sí" : "No"}'),
          Text("|"),

          Text('Bicis disponibles: ${status.bikesAvailable}'),
          Text("|"),

          Text('Estaciones disponibles: ${status.docksAvailable}'),
          Text("|"),

          Text("Estado: ${status.status.name}"),
        ],
      ),
    );
  }

  Widget StationsList() {
    return Expanded(
      
      child: 
        ListView.builder(
          itemCount: informationData.length,
          itemBuilder: (context, index) {
            final info = informationData[index];
            final status = statusData.firstWhere((s) => s.id == info.station_id, orElse: () => 
              Status(id: info.station_id, isRenting: false, bikesAvailable: 0, docksAvailable: 0, 
              lastReported: 0, status: StatusEnum.UNKNOWN, vehicleTypesAvailable: [],
              bikesDisabled: 0, docksDisabled: 0, isInstalled: false, isReturning: false));
            
            ListTile(
                title: Text('${info.name}', textAlign: TextAlign.center,),
                subtitle: Text('Bicis disponibles: ${status.bikesAvailable}',textAlign: TextAlign.center),
                leading: ElevatedButton(
                  onPressed:(){
                  Navigator.pop(context, status);
                }, 
                child: Icon(Icons.star)),
            );
          }
        )
        
      );
    
  }       
}