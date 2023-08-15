import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:s_web/homescreenapps.dart';
import 'package:path_provider/path_provider.dart' as path_finder;
import 'package:s_web/homescreen.dart';

import 'imp_classes/to_do_list.dart';
import 'imp_classes/note_class.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDirctory=await path_finder.getApplicationDocumentsDirectory();
  Hive.init(appDirctory.path);
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(todolistAdapter());
  var box = await Hive.openBox("store");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(future: Hive.openBox("store"),builder:(BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          var box = Hive.box("store");
          return Home_apps();
        }
        else{
          return Home();
        }

      }),
      theme: ThemeData(
          primaryColor: Colors.teal[900]),
          color: Colors.teal[900],
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    super.dispose();
  }
}

