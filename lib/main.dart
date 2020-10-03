import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_floor_demo/db/dao/person_dao.dart';
import 'package:flutter_floor_demo/utils/constants.dart';
import 'package:flutter_floor_demo/utils/router.dart';
import 'package:flutter_floor_demo/widgets/user_card_widget.dart';

import 'db/app_database.dart';
import 'db/entities/person.dart';
import 'models/person_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder(DB_NAME + '.db').build();
  final personDao = database.personDao;

  runApp(MyApp(personDao: personDao,));
}

class MyApp extends StatelessWidget {
  final PersonDao personDao;

  const MyApp({Key key, this.personDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Floor Demo App', personDao: personDao,),
      onGenerateRoute: Router.generateRoutes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.personDao}) : super(key: key);

  final String title;
  final PersonDao personDao;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var database;
  PersonDao personDao;
  TextEditingController _nameEditController = TextEditingController();
  static const platform = const MethodChannel('samples.flutter.dev/toast');

  @override
  void initState() {
    super.initState();
    personDao = widget.personDao;
  }

  @override
  void dispose() {
    _nameEditController.dispose();
    super.dispose();
  }

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    borderSide: BorderSide(color: Colors.orange, width: 2.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 18.0,),
              Text('Add New Person in Database', style: TextStyle(color: Colors.blueGrey, fontSize: 16.0, fontWeight: FontWeight.bold),),
              getTextField(),
              getButtonRow(),
              SizedBox(height: 0.0,),
              Text('Persons List:', style: TextStyle(color: Colors.blueGrey, fontSize: 16.0, fontWeight: FontWeight.bold),),
              SizedBox(height: 4.0,),
              getListView(),
            ],
          ),
        )
    );
  }

  Future<void> _addPersonToDb() async {
    final name = _nameEditController.text;
    if (name.trim().isEmpty) {
      _nameEditController.clear();
    }
    else{
      if (name.trim().length > 2){
        final person = Person(null, name);
        await personDao.insertPerson(person);
        _nameEditController.clear();
        try {
          await platform.invokeMethod('toast');
        } on PlatformException catch (e) {
          print(e.toString());
        }
        print('success');
      }
      else{
        print("Name should be greater than 2 characters!");
        _nameEditController.clear();
      }
    }
  }

  void _showError() {
    print('Name must not be Null && should be greater than 2 char.');
  }

  Future<void> _deleteAllPersonsFromDb() async {
    _nameEditController.clear();
    await personDao.deleteAllPersons();
    setState(() {

    });
    try {
      await platform.invokeMethod('delete');
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  getButtonRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 10.0, 32.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
              color: Colors.orange,
              child: Text('Add Person', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
              onPressed: (){
                _addPersonToDb();
              }
          ),
          MaterialButton(
            color: Colors.orange,
            child: Text('Delete All', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
            onPressed: _deleteAllPersonsFromDb,
          ),
        ],
      ),
    );
  }

  getTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
      child: TextFormField(
        controller: _nameEditController,
        style: TextStyle(color: Colors.blueGrey, fontSize: 16.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          labelText: "Person Name",
          labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 16.0, fontWeight: FontWeight.bold),
          hintText: "Enter person name",
          hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14.0, fontWeight: FontWeight.bold),
          enabledBorder: _border,
          focusedBorder: _border,
          disabledBorder: _border,
        ),
      ),
    );
  }

  getListView() {
    return Expanded(
      flex: 0,
      child: StreamBuilder<List<Person>>(
        stream: personDao.getAllPersons(),
        builder: (_, snapshot){
          if (!snapshot.hasData) return Container();
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (_, int index){
                return GestureDetector(
                  onTap: (){
                    getPersonDetails(snapshot.data[index].id, snapshot.data[index].name);
                  },
                  child: UserCard(name: snapshot.data[index].name,),
                );
              }
          );
        },
      ),
    );
  }

  void getPersonDetails(int personId, String personName) {
    Navigator.pushNamed(context, ROUTE_PERSON_DETAILS, arguments: PersonData(id: personId, name: personName));
  }
}
