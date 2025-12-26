import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t5_1/model/information.dart';
import 'package:t5_1/model/status.dart';
import 'package:t5_1/view/station_detail.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class FavStation extends StatefulWidget {
    int last_updated;
    Status status;
    InformationStation information;
    final List<Status> statusData;
    final List<InformationStation> informationData;

    FavStation({
      super.key, 
      required this.last_updated,
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
          Text('${widget.last_updated}'),
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
    String compensa = "NO"; 
    if (widget.status.bikesAvailable > 1){
      compensa = "SI";
    }
    else if (widget.status.bikesAvailable == 1){
      compensa = "QUIZÁS";
    }
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
          Text("Debería bajar a por una bici?: $compensa"),

          ElevatedButton(
            onPressed: _exportPdf,
            child: Text('Exportar a PDF'),
          ),
        ],
      ),
    );
  }
  Future<Uint8List> _buildPdf() async {
    final pdf = pw.Document();

    String compensa = "NO";
    if (widget.status.bikesAvailable > 1) {
      compensa = "SI";
    } else if (widget.status.bikesAvailable == 1) {
      compensa = "QUIZÁS";
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Estación: ${widget.status.id} ${widget.information.name}', style: pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 8),
                pw.Text('Dirección: ${widget.information.adress}'),
                pw.Text('Actualizado por última vez: ${widget.status.lastReported}'),
                pw.Text('Hay bicis disponibles: ${widget.status.isRenting ? "Sí" : "No"}'),
                pw.Text('Bicis disponibles: ${widget.status.bikesAvailable}'),
                pw.Text('Estaciones disponibles: ${widget.status.docksAvailable}'),
                pw.Text('Estado: ${widget.status.status.name}'),
                pw.Text('Debería bajar a por una bici?: $compensa'),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> _exportPdf() async {
    final bytes = await _buildPdf();
    await Printing.sharePdf(bytes: bytes, filename: 'fav_station_${widget.status.id}.pdf');
  }

  Widget StationsList() {
    return Expanded(
      
      child: ListView.builder(
          itemCount: widget.informationData.length,
          itemBuilder: (context, index) {
            final info = widget.informationData[index];
            final status = widget.statusData.firstWhere((s) => s.id == info.station_id);
            
            return ElevatedButton(
              onPressed: () async{
                var nuevoFavorito = await Navigator.push(context, MaterialPageRoute(builder:(context) => StationDetail(
                  last_updated: widget.last_updated,
                  status: status, 
                  information: info, 
                  statusData: widget.statusData,
                  informationData: widget.informationData
              )));
                if (nuevoFavorito != null){
                  setState(() {
                    widget.status = nuevoFavorito;
                    widget.information = widget.informationData.firstWhere((s) => s.station_id == nuevoFavorito.id);
                  });
                }
              } , 
              child: ListTile(
                title: Text('${info.name}', textAlign: TextAlign.center,),
                subtitle: Text('Bicis disponibles: ${status.bikesAvailable}',textAlign: TextAlign.center),
                leading: ElevatedButton(onPressed:(){
                  setState(() {
                    widget.status = status;
                  });
                } , child: Icon(Icons.star)),
              ),
            );
          },
        )
        
      );
  }
}
