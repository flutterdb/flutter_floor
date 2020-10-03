
import 'package:floor/floor.dart';
import 'package:flutter_floor_demo/db/entities/person.dart';

@dao
abstract class PersonDao{

  @Query("SELECT * FROM tbl_person")
  Stream<List<Person>> getAllPersons();

  @Query("SELECT * FROM tbl_person WHERE id =:id")
  Stream<Person> getPersonById(int id);

  @insert
  Future<void> insertPerson(Person person);

  @Query("DELETE FROM tbl_person")
  Future<void> deleteAllPersons();

}