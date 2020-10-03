
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floor_demo/db/dao/person_dao.dart';
import 'package:flutter_floor_demo/models/person_data.dart';

class PersonDetails extends StatefulWidget{

  final PersonData personData;
  final PersonDao personDao;

  const PersonDetails({Key key, @required this.personData, this.personDao,}) : super(key: key);

  @override
  _PersonDetailsState createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Person Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            SizedBox(height: 20.0,),
            Center(
              child: CircleAvatar(
                radius: 36.0,
                backgroundColor: Colors.brown,
                child: Text(widget.personData.name.substring(0,2).toUpperCase(),
                style: TextStyle(color: Colors.white60, fontSize: 40.0, fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 16.0,),
            Text('Person ID: ' + widget.personData.id.toString(), style: TextStyle(color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 12.0,),
            Text('Person Name: ' + widget.personData.name, style: TextStyle(color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}