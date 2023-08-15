import 'package:flutter/material.dart';
import 'package:s_web/lists.dart';
import 'package:s_web/notes.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(title: Text("Noted", style: TextStyle(color: Colors.grey[300], letterSpacing: 2.75)),
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.teal[900]),
        body: Column(children: [
          Container (child: Container(alignment: Alignment.center,
            child: Text("Hey, it seems a bit lonely here..",
              style: const TextStyle(fontWeight: FontWeight.w900,fontFamily: "NotoSans", color: Colors.white, fontSize: 16.8, letterSpacing: 2.0), textAlign: TextAlign.center,),
          )
            ,margin:EdgeInsets.fromLTRB(50.0,60.0,20.0,0.0),),
          Container(child:Text("Add your first Action", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 12.8,letterSpacing: 1.5, fontFamily: "Notosans" , color: Colors.white), textAlign: TextAlign.center,), margin: EdgeInsets.fromLTRB(50.0, 40.0, 60.0, 0.0),),
          Container(child: SizedBox(width: 140, height: 50,child: TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>notes()));
          } , child: Text("Add a Note", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[50]),), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal[700])),)),margin: EdgeInsets.fromLTRB(55.75, 80.0, 60.0, 0.0),),
          Container(child: SizedBox(width: 140, height: 50,child: TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Lists()));
          } , child: Text("Add a List", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[50]),), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal[700])),)),margin: EdgeInsets.fromLTRB(55.75, 80.0, 60.0, 0.0),)
          , ],
        ),
        floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end,children: [Container(child: FloatingActionButton(onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>notes()));
        },child: Icon(Icons.note_add),backgroundColor: Colors.teal[900],),margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),),Container(child: FloatingActionButton(onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Lists()));
        },child: Icon(Icons.list_outlined),backgroundColor: Colors.teal[900],),margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),)],)
    );
  }
}
