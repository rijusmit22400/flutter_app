import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s_web/list_page_edit.dart';
import 'imp_classes/to_do_list.dart';


class List_Page extends StatefulWidget {
  @override
  to_do_list items;
  int index;
  List_Page({Key? key,required this.items,required this.index}) : super(key:key);
  @override
  State<List_Page> createState() => _HomeState(items: this.items,index: this.index);
}
String reduce(String word) {
  String n_word = "";
  if (word.length > 20) {
    n_word = word.substring(0, 18);
    n_word += "...";
  }
  else{
    n_word=word;
  }
  return n_word;
}
class _HomeState extends State<List_Page> {
  var items;
  var index;
  _HomeState({this.items,this.index});
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(title: Text(widget.items.title, style: TextStyle(color: Colors.grey[300], letterSpacing: 2.75)),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.teal[900],
      ),
      body: Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),child: ColoredBox(color: CupertinoColors.tertiarySystemFill,child: SizedBox(width: 360, height: 630,child: Container(
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.teal.shade900,
            child: ValueListenableBuilder(
              valueListenable:  ValueNotifier(Hive.box("store").get(index)),
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: widget.items.status.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        elevation: 2.5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),side: BorderSide(width: 0.98,color: Colors.grey.shade900)),
                        color: CupertinoColors.systemGrey5.darkColor,
                        shadowColor: Colors.black,
                        borderOnForeground: true,
                        child: Container(
                          margin: EdgeInsets.only(top: 5.0),
                          padding:EdgeInsets.all(22.75),
                          child : Stack(
                            children: [Container(margin: EdgeInsets.fromLTRB(10.0,10.0,40.0,0.0),child: Text(reduce(widget.items.item[index]),style: TextStyle(fontFamily: "OpenSans", color: Colors.lightGreen[200],fontSize: 20,),)),Container(margin: EdgeInsets.only(left: 250.0),
                              child: IconButton(onPressed: (){
                                setState((){
                                  bool value = widget.items.status[index];
                                  widget.items.status[index] = (!value);
                                });
                              } ,icon:widget.items.status[index]?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),color: Colors.lightGreen[200],),
                            )],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      )

        ,),), padding: EdgeInsets.fromLTRB(25.0, 60.0, 10.0, 10.0),),
    floatingActionButton: FloatingActionButton(onPressed: () {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>List_edit(schedule: widget.items,index: widget.index)));
    }, child: Icon(CupertinoIcons.pencil), backgroundColor: Colors.teal[900]),
    );
  }
}
