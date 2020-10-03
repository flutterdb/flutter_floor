
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_floor_demo/db/dao/person_dao.dart';
import 'package:flutter_floor_demo/db/entities/person.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Person])
abstract class AppDatabase extends FloorDatabase{
  PersonDao get personDao;
}

