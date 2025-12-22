
import 'package:flutter/material.dart';
import 'package:t5_1/data/simple_api_information.dart';
import 'package:t5_1/data/simple_api_status.dart';
import 'package:t5_1/data/simple_repository_information.dart';
import 'package:t5_1/data/simple_repository_status.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  
  @override
  Widget build (BuildContext context){
    ApiInformation apiInfo = ApiInformation();
    ApiStatus apiStatus = ApiStatus();
    RepositoryInformation infoRepo = RepositoryInformation(apiInfo);
    RespositoryStatus statusRepo = RespositoryStatus(apiStatus);
    Viewmodel viewmodel = Viewmodel(infoRepo, statusRepo);

    viewmodel.getData();
    if(viewmodel.loading) {
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
        ),
        body: Center(
          child: Text('Welcome'),
        ),
      );
    }
  }
}

