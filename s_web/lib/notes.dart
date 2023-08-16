import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:s_web/imp_classes/note_class.dart';


void main(){
  return runApp(MaterialApp(theme: ThemeData( primaryColor: Colors.teal[900]),home: notes(),));
}
class notes extends StatefulWidget {
  const notes({super.key});
  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  var box = Hive.box("store");
  var _title="";
  final _title_controller=TextEditingController();
  final _content_controller=TextEditingController();
  var _enable_title=true;
  void title_display(String val){
    if(val.length>=6){
      val=val.substring(0,7);
      val=val+"...";
    }
    _title=val;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(centerTitle: true,
        title: Text("Add a Note", style: TextStyle(color: Colors.grey[300], letterSpacing: 2.75)),backgroundColor: Colors.teal[900],
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.teal.shade900,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
              child: Column(children: [TextFormField(
                maxLength: 30,
                style: TextStyle(
              color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: "NotoSans",
                  letterSpacing: 1),
                onChanged: (val){
                    setState(() {
                      title_display(val);
                    });
                },
                cursorColor: Colors.teal[600],
                controller: _title_controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    iconColor: Colors.white54,
                    icon: Icon(Icons.note_add),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent.shade700,width: 1.95)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal.shade700,width: 2.0)
                    ),
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        fontFamily: "NotoSans",
                        letterSpacing: 2.3)),
              ),
              Container(margin: EdgeInsets.fromLTRB(0.0, 20.0, 120.0, 0.0),child: Text("The title for the note is ${_title}",style: TextStyle(color: Colors.white54,fontSize: 15.0,fontFamily: "NotoSans"))),Container(decoration: BoxDecoration(color: CupertinoColors.secondaryLabel,borderRadius: BorderRadius.circular(20.0),),child:
                Column(children:
                  [SizedBox(
                    height: 350, // set desired height here
                    child: TextFormField(
                      cursorColor: Colors.teal[700],
                      controller: _content_controller,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontFamily: "NotoSans",
                          letterSpacing: 1),
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(border: InputBorder.none,hintStyle: TextStyle(color:Colors.white54,fontFamily: "NotoSans",wordSpacing: 2.0),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.tealAccent)),enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.teal)),hintText: "Your note Goes here.."),
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),],),margin: EdgeInsets.only(top: 40.0,left: 10.0,right: 10.0)),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    children:[SizedBox(height: 40.0, width: 120.0,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(onPressed: () async {
                      final note = Note(title: _title_controller.text,content: _content_controller.text);
                      var box = Hive.box("store");
                      box.add(note);
                      print([note.title,note.content]);
                      print("\n\n\n\n\n");
                      _content_controller.clear();
                      _title_controller.clear();
                      Navigator.pop(context);
                    },label: Text("Attach", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[50]),), style: ButtonStyle(shadowColor: MaterialStateProperty.all(Colors.black87),elevation: MaterialStateProperty.all(5),backgroundColor: MaterialStateProperty.all(Colors.teal[700])), icon: Icon(Icons.sticky_note_2_sharp),),
                        )),
                      SizedBox(height: 40.0, width: 120.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(Icons.restore_from_trash),label: Text("Discard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[50]),), style: ButtonStyle(shadowColor: MaterialStateProperty.all(Colors.black87),elevation: MaterialStateProperty.all(5),backgroundColor: MaterialStateProperty.all(Colors.teal[700])),),
                          ))],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,),
                )
              ],
    ),
            ),
          ),
        ),
      ),
    );
  }
}
