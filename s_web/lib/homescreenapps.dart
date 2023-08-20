import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:s_web/homescreen.dart';
import 'package:s_web/imp_classes/note_class.dart';
import 'package:s_web/list_page.dart';
import 'package:s_web/lists.dart';
import 'package:s_web/notes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'imp_classes/to_do_list.dart';
import 'note_page.dart';

void main() {
  return runApp(Home_apps());
}

class Home_apps extends StatefulWidget {
  @override
  State<Home_apps> createState() => _Home_appsState();
}

class _Home_appsState extends State<Home_apps> {
  @override
  late var mybox;
  void initState() {
    super.initState();
    mybox = Hive.openBox("store");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
            title: Text("Noted",
                style: TextStyle(color: Colors.grey[300], letterSpacing: 2.75)),
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.teal[900]),
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.teal.shade900,
            child: WatchBoxBuilder(
              box: Hive.box("store"),
              builder: (context, mybox) {
                return mybox.isEmpty
                    ? Column(
                        children: [
                          Container(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Hey, it seems a bit lonely here..",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "NotoSans",
                                    color: Colors.white,
                                    fontSize: 16.8,
                                    letterSpacing: 2.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(50.0, 60.0, 20.0, 0.0),
                          ),
                          Container(
                            child: Text(
                              "Add your first Action",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.8,
                                  letterSpacing: 1.5,
                                  fontFamily: "Notosans",
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            margin: EdgeInsets.fromLTRB(50.0, 40.0, 60.0, 0.0),
                          ),
                          Container(
                            child: SizedBox(
                                width: 140,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => notes()));
                                  },
                                  child: Text(
                                    "Add a Note",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[50]),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.teal[700])),
                                )),
                            margin: EdgeInsets.fromLTRB(55.75, 80.0, 60.0, 0.0),
                          ),
                          Container(
                            child: SizedBox(
                                width: 140,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Lists()));
                                  },
                                  child: Text(
                                    "Add a List",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[50]),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.teal[700])),
                                )),
                            margin: EdgeInsets.fromLTRB(55.75, 80.0, 60.0, 0.0),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: mybox.length,
                        itemBuilder: (BuildContext context, int index) {
                          final box = Hive.box("store");
                          final elt = box.getAt(index);
                          if (elt.runtimeType == Note) {
                            final note = elt as Note;
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0,
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 30.0),
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion: DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      icon: CupertinoIcons.trash,
                                      backgroundColor:
                                          Colors.deepOrange.shade900,
                                      onPressed: (BuildContext context) {
                                        setState(() {
                                          mybox.deleteAt(index);
                                        });
                                      },
                                    )
                                  ],
                                ),
                                child: Card(
                                  elevation: 2.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      side: BorderSide(
                                          width: 0.98,
                                          color: Colors.grey.shade900)),
                                  color: CupertinoColors.systemGrey5.darkColor,
                                  shadowColor: Colors.black,
                                  borderOnForeground: true,
                                  child: TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)))),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.teal[100])),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Note_Page(
                                                    note_content: note,
                                                    index: index,
                                                  )));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 5.0, bottom: 5),
                                        padding: EdgeInsets.all(22.75),
                                        child: Stack(children: [
                                          ListTile(
                                            title: Text(
                                              note.title,
                                              style: TextStyle(
                                                  color:
                                                      Colors.lightGreen[200]),
                                            ),
                                            subtitle: Text(
                                                note.content.length < 25
                                                    ? note.content
                                                    : note.content
                                                            .substring(0, 25) +
                                                        "...",
                                                style: TextStyle(
                                                    color: Colors.white38)),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(top: 25),
                                              alignment: Alignment(0.789, 1),
                                              child: Icon(
                                                Icons.note_add,
                                                color: Colors.lightGreenAccent,
                                              ))
                                        ])),
                                  ),
                                ),
                              ),
                            );
                          } else if (elt.runtimeType == to_do_list) {
                            final list = elt as to_do_list;
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0,
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 30.0),
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion: DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      icon: CupertinoIcons.trash,
                                      backgroundColor:
                                          Colors.deepOrange.shade900,
                                      onPressed: (context) {
                                        setState(() {
                                          mybox.deleteAt(index);
                                        });
                                      },
                                    )
                                  ],
                                ),
                                child: Card(
                                  elevation: 2.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      side: BorderSide(
                                          width: 0.98,
                                          color: Colors.grey.shade900)),
                                  color: CupertinoColors.systemGrey5.darkColor,
                                  shadowColor: Colors.black,
                                  borderOnForeground: true,
                                  child: TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)))),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.teal[100])),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => List_Page(
                                                    items: list,
                                                    index: index,
                                                  )));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0),
                                        padding: EdgeInsets.all(22.75),
                                        child: Stack(children: [
                                          ListTile(
                                            title: Text(
                                              list.title,
                                              style: TextStyle(
                                                  color:
                                                      Colors.lightGreen[200]),
                                            ),
                                            subtitle: Text(
                                                "To-Do-List " + "...",
                                                style: TextStyle(
                                                    color: Colors.white38)),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(top: 25),
                                              alignment: Alignment(0.789, 1),
                                              child: Icon(
                                                Icons.list,
                                                color: Colors.lightGreenAccent,
                                              ))
                                        ])),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      );
              },
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => notes()));
                },
                child: Icon(Icons.note_add),
                backgroundColor: Colors.teal[900],
              ),
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
            ),
            Container(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Lists()));
                },
                child: Icon(Icons.list_outlined),
                backgroundColor: Colors.teal[900],
              ),
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            )
          ],
        ));
  }
}
