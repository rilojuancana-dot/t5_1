import 'package:flutter/material.dart';
import 'package:t5_1/data/simple_api_information.dart';
import 'package:t5_1/data/simple_api_status.dart';
import 'package:t5_1/data/simple_repository_information.dart';
import 'package:t5_1/data/simple_repository_status.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';

void main() async{
  runApp(MyApp());
  ApiInformation apiInfo = ApiInformation();
  ApiStatus apiStatus = ApiStatus();
  RepositoryInformation infoRepo = RepositoryInformation(apiInfo);
  RespositoryStatus statusRepo = RespositoryStatus(apiStatus);
  Viewmodel viewmodel = Viewmodel(infoRepo, statusRepo);

  viewmodel.getData();
  while(viewmodel.loading) {
    
  }
  if (viewmodel.error != null){
    
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hola Mundo'),
        ),
        body: Center(
          child: Text('¡Mi primera app en Flutter!'),
        ),
      ),
    );
  }
}
