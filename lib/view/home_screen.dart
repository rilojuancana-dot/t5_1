
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';


class HomeScreen extends StatelessWidget{
  
  @override
  Widget build (BuildContext context){;
    final viewmodel = context.watch<Viewmodel>();

    viewmodel.getData();
    debugPrint(viewmodel.statusData.length.toString());
    viewmodel.statusData.forEach( (element) {
      debugPrint(element.toString());
    });
    
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

