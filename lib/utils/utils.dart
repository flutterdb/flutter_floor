
import 'package:flutter_floor_demo/db/app_database.dart';
import 'package:flutter_floor_demo/db/dao/person_dao.dart';
import 'package:flutter_floor_demo/utils/constants.dart';

class Utils{

  static final _instance = Utils._internal();
  Utils._internal();

  static Utils getInstance(){
    return _instance;
  }

  Future<PersonDao> getPersonDao() async {
    final database = await $FloorAppDatabase.databaseBuilder(DB_NAME + ".db").build();
    return database.personDao;
  }
}