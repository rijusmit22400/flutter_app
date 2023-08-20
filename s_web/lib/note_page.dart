import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s_web/note_page_edit.dart';
import 'package:s_web/imp_classes/note_class.dart';

class Note_Page extends StatelessWidget {
  Note note_content;
  int index;
  Note_Page({super.key, required this.note_content, required this.index});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Notechange(note_content),
        builder: (context, Note, _) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
                title: Text(note_content.title,
                    style: TextStyle(
                        color: Colors.grey[300], letterSpacing: 2.75)),
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.teal[900]),
            body: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.teal.shade900,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50.0),
                      alignment: Alignment(0, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(4.50),
                        child: Card(
                          elevation: 2.5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              side: BorderSide(
                                  width: 0.98, color: Colors.grey.shade700)),
                          color: CupertinoColors.systemGrey5.darkColor,
                          shadowColor: Colors.black,
                          borderOnForeground: true,
                          child: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            padding: EdgeInsets.all(22.75),
                            child: Container(
                              height: 475,
                              width: 450,
                              child: ScrollConfiguration(
                                behavior: NoGlowScrollBehavior(),
                                child: SingleChildScrollView(
                                    child: Text(
                                  note_content.content,
                                  style: TextStyle(
                                      fontFamily: "NotoSans",
                                      color: Colors.white,
                                      fontSize: 17),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 25),
                        alignment: Alignment(0.875, 3),
                        child: FloatingActionButton(
                          backgroundColor: Colors.teal[900],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => notes_edit(
                                          file: note_content,
                                          index: index,
                                        )));
                          },
                          child: Icon(CupertinoIcons.pencil),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Notechange extends ValueNotifier<Note> {
  Notechange(Note value) : super(value);

  void changed_content(String n_content, String n_title) {
    value.content = n_content;
    value.title = n_title;
    notifyListeners();
  }
}
