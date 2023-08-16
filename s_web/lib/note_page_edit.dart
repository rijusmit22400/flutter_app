import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:s_web/imp_classes/note_class.dart';



class notes_edit extends StatefulWidget {
  Note file;
  int index;
  notes_edit({super.key,required this.file,required this.index});
  @override
  State<notes_edit> createState() => _notes_editState();
}
class _notes_editState extends State<notes_edit> {
  @override
  var box = Hive.box("store");
  var _title="";
  var _title_controller=TextEditingController();
  var _content_controller=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _title_controller=TextEditingController(text: widget.file.title);
    _content_controller=TextEditingController(text: widget.file.content);
    super.initState();
  }
  var _enable_title=true;
  void title_dsplay(val){
    if(val.toString().length>=6){
      for(int i=7;i<val.toString().length;i++){
        val[i]+="";
      }
      val=val+"...";
    }
    _title=val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(centerTitle: true,
        title: Text("Edit", style: TextStyle(color: Colors.grey[300], letterSpacing: 2.75)),backgroundColor: Colors.teal[900],
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: "NotoSans",
                    letterSpacing: 1),
                onChanged: (val){
                  setState(() {
                    title_dsplay(val);
                  });
                },
                cursorColor: Colors.teal[600],
                controller: _title_controller,
                decoration: InputDecoration(
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
                    controller: _content_controller,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontFamily: "NotoSans",
                        letterSpacing: 1),
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(hintStyle: TextStyle(color:Colors.white54,fontFamily: "NotoSans",wordSpacing: 2.0),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.tealAccent)),enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.teal)),hintText: "Your note Goes here.."),
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
                            box.putAt(widget.index,note);
                            print([note.title,note.content]);
                            print("\n\n\n\n\n");
                            _content_controller.clear();
                            _title_controller.clear();
                            Navigator.pop(context);
                          },label: Text("Edit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[50]),), style: ButtonStyle(shadowColor: MaterialStateProperty.all(Colors.black87),elevation: MaterialStateProperty.all(5),backgroundColor: MaterialStateProperty.all(Colors.teal[700])), icon: Icon(Icons.mode_edit_outline_outlined),),
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
