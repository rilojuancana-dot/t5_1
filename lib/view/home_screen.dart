
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t5_1/view/fav_station.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';


class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  
  @override
  Widget build (BuildContext context){
    final viewmodel = context.watch<Viewmodel>();

    
    if(viewmodel.loading) {
      viewmodel.getData();
      return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Loading'),
      ),
    );
    }
    else if (viewmodel.error != null){
      return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('${viewmodel.error}'),
      ),
    );
    }
    else {
      return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        leading: ElevatedButton(onPressed: (){
          viewmodel.getData();
        }, child: Icon(Icons.refresh)),
      ),
      body: Center(
        child: FavStation(
          last_updated: viewmodel.lastUpdated,
          status: viewmodel.favStationStatus!, 
          information: viewmodel.favStationInformation!,
          statusData: viewmodel.statusData,
          informationData: viewmodel.infoData,
        ),
      )
    );
    }
  }
}

