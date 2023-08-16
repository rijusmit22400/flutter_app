import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:s_web/imp_classes/to_do_list.dart';


class List_edit extends StatefulWidget {
  to_do_list schedule;
  int index;
  List_edit({Key? key,required this.schedule, required this.index}) : super(key:key);
  @override
  State<List_edit> createState() => _HomeState(schedule: this.schedule, index: this.index);
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
class _HomeState extends State<List_edit> {
  String title="";
  to_do_list schedule;
  int index;
  List item=[];
  List status=[];
  _HomeState({required this.schedule, required this.index});
  @override
  final _controller =TextEditingController();
  final _title_controller =TextEditingController();
  @override
  List n_item=[];
  List n_status=[];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(title: Text("Edit", style: TextStyle(color: Colors.grey[300], letterSpacing: 2.75)),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.teal[900],
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.teal.shade900,
          child: SingleChildScrollView(
            child: Column(children: [Padding(
              padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
              child: TextFormField(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: "NotoSans",
                    letterSpacing: 1),
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
                        letterSpacing: 2.3),border:InputBorder.none),
              ),
            ),Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),child: ColoredBox(color: CupertinoColors.tertiarySystemFill,child: SizedBox(width: 360, height: 430,child: Container( margin: EdgeInsets.only(top: 5,bottom: 7.5),
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Colors.teal.shade900,
                  child: ListView.builder(itemCount: (widget.schedule.item.length+item.length),itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.50),
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
                                children: [Container(margin: EdgeInsets.fromLTRB(10.0,10.0,40.0,0.0),child: Text(reduce(widget.schedule.item[index]),style: TextStyle(fontFamily: "OpenSans", color: Colors.lightGreen[200],fontSize: 20,),)),Container(margin: EdgeInsets.only(left: 250.0),
                                  child: IconButton(onPressed: (){
                                    setState((){
                                      widget.schedule.item.remove(widget.schedule.item[index]);
                                      widget.schedule.status.remove(widget.schedule.status[index]);
                                    });
                                  } ,icon:Icon(Icons.close,color: Colors.grey[700],),),
                                )],
                              ),
                            ),
                          ),
                        );
                    },
                  ),
                ),
              ),
            )

              ,),), margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),),
              Container(child: SizedBox(height: 32.95, width: 150.5, child: ElevatedButton.icon(onPressed: () {
                showDialog(context: context, builder: (context){
                  return Add_taskBox(item_addingController: _controller,onSave: (){
                    setState(() {
                      widget.schedule.item.add(_controller.text);
                      widget.schedule.status.add(false);
                    });
                    Navigator.of(context).pop();
                    _controller.clear();
                  },onCancel: (){
                    Navigator.of(context).pop();
                  },);
                },
                );
              },label: Text("Add new item"),icon: Icon(CupertinoIcons.pen),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal[700])),)), margin: EdgeInsets.fromLTRB(0.0, 25.5, 0.0, 0.0),),
              Container(child: Row(
                children:[SizedBox(height: 40.0, width: 120.0,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(onPressed: () {
                        widget.schedule.item=widget.schedule.item+item;
                        widget.schedule.status=widget.schedule.status+status;
                        to_do_list n_ob=to_do_list(title: widget.schedule.title, item: widget.schedule.item, status:widget.schedule.status);
                        var box = Hive.box("store");
                        box.putAt(widget.index,n_ob);
                        _title_controller.clear();
                        Navigator.pop(context);
                      }, icon: Icon(Icons.list_alt),label: Text("Edit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[50]),), style: ButtonStyle(shadowColor: MaterialStateProperty.all(Colors.black87),elevation: MaterialStateProperty.all(5),backgroundColor: MaterialStateProperty.all(Colors.teal[700])),),
                    )),SizedBox(height: 40.0, width: 120.0,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(onPressed: () {
                        widget.schedule.item=widget.schedule.item;
                        widget.schedule.status=widget.schedule.status;
                        Navigator.pop(context);
                      }, icon: Icon(Icons.restore_from_trash),label: Text("Discard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[50]),), style: ButtonStyle(shadowColor: MaterialStateProperty.all(Colors.black87),elevation: MaterialStateProperty.all(5),backgroundColor: MaterialStateProperty.all(Colors.teal[700])),),
                    ))],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,), margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
              SizedBox(height: 60.0,)]),
          ),
        ),
      ),
    );
  }
}
class Add_taskBox extends StatelessWidget {
  final item_addingController;
  VoidCallback onSave;
  VoidCallback onCancel;
  Add_taskBox({super.key, required this.item_addingController, required this.onSave, required this.onCancel});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(CupertinoIcons.pencil_ellipsis_rectangle),
      iconColor: Colors.white60,
      backgroundColor: Colors.blueGrey.shade900,
      content: Container(height: 120,
        child: Column(children: [
          TextField(
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontFamily: "NotoSans",
                letterSpacing: 1),
            cursorColor: Colors.teal,
            controller: item_addingController,
            decoration: InputDecoration(
                hintText: "Add Task..",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade700,width: 1.95)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade700,width: 2.0)
                ),
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontFamily: "NotoSans",
                    letterSpacing: 2.3),border: InputBorder.none),
          ),
          SizedBox(height: 8,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [ElevatedButton(onPressed: (){
            onSave();
          }, child: Icon(CupertinoIcons.check_mark, color: Colors.green),style: ButtonStyle(elevation: MaterialStateProperty.all(1.5),backgroundColor: MaterialStateProperty.all(CupertinoColors.separator)),),ElevatedButton(onPressed: (){
            onCancel();
          }, child: Icon(CupertinoIcons.clear,color: Colors.red,), style: ButtonStyle(elevation: MaterialStateProperty.all(1.5),backgroundColor: MaterialStateProperty.all(CupertinoColors.separator)),),],)],),
      ),
      elevation: 5.6,
    );
  }
}

