
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floor_demo/models/person_data.dart';
import 'package:flutter_floor_demo/screens/person_details.dart';
import 'package:flutter_floor_demo/utils/constants.dart';

class Router{

  static Route<dynamic> generateRoutes(RouteSettings settings){

    switch(settings.name){
      case ROUTE_PERSON_DETAILS:
        var data = settings.arguments as PersonData;
        return MaterialPageRoute(builder: (_) => PersonDetails(personData: data,));
      default:
        return MaterialPageRoute(
            builder: (BuildContext ctx) => Scaffold(
              body: Container(
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Text('Invalid Route Name!'),
                ),
              ),
            ),
        );
    }
  }
}