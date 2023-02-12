import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'package:opendome/Screens/Stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenDome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainView(title: 'OpenDome'),
    );
  }
}

class MainView extends StatefulWidget{
  const MainView({super.key, required this.title});

  final String title;

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView>{
  void stream() async{
    var response = await http.get(Uri.parse("http://192.168.1.254:80?custom=1&cmd=2019"));
    if(response.statusCode == 200){
      var xmlDocument = XmlDocument.parse(response.body);
      var streamUrl = xmlDocument.getAttribute('MovieLiveViewLink');
      
      if(streamUrl != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => StackedVideoView(url: streamUrl)));
      }
    }   
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      //appBar: AppBar(title: Text(Widget.title),),

      body: Center(
        child: ElevatedButton(child: Text("Stream"), onPressed: stream,),
      ),
    );
  }
}
