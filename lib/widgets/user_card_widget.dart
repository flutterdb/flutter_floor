
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget{
  final String name;

  const UserCard({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(28.0, 4.0, 32.0, 4.0),
      height: 70,
      child: Card(
        color: Colors.grey.shade200,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(getRandomColor(), getRandomColor(), getRandomColor(), getRandomColor()),
                child: Text(
                  '$name'.substring(0,2),
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 12.0,),
              Expanded(
                child: Text(
                  '$name',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int getRandomColor(){
    int min = 100;   // 3 digit Min
    int max = 999;   // 3 digit Max
    var rnd = new Random();
    var rNum = min + rnd.nextInt(max - min);
    return rNum;
  }
}