
import 'package:floor/floor.dart';

@Entity(tableName: "tbl_person")
class Person{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;

  Person(this.id, this.name);
}