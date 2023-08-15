import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s_web/homescreen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context)=> Home(),
        ));
    });
  }
  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(width:double.infinity ,decoration: BoxDecoration(color: Colors.blueGrey[100]),
    child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      Container(child: Image.asset('assets/white_pencil.png',width: 100,height: 100,color: Colors.cyan.shade900,))
    ,Text("Noted",style: TextStyle(fontFamily: "OpenSans",color: Colors.teal[900],fontSize: 32))],),
    ),);
  }
}
