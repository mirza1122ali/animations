

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures and animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  Animation <double> animation;
  AnimationController controller ;
  int numtaps = 0;
  int numdoubletaps = 0;
  int numlongpress = 0;
  double posx = 0.0;
  double posy = 0.0;
  double boxsize = 0.0;
  final double fullboxsize = 150.0;
@override
  void dispose() {
   controller.dispose();
    super.dispose();
  }
  void initstate(){
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds:5000),
    vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addListener(() {
      setState(() {
        boxsize = fullboxsize*animation.value;
      });
      center(context);
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if(posx == 0.0){
      center(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('gesture and aniimation'),
      ),
      body:GestureDetector(
        onTap: (){
          setState(() {
            numtaps++;
          });
        },
        onDoubleTap: (){
          setState(() {
            numdoubletaps++;
          });
        },
        onLongPress: (){
          setState(() {
            numlongpress++;
          });
          
        },
        onVerticalDragUpdate: (DragUpdateDetails value){
          setState(() {
            double delta = value.delta.dy;
            posy+= delta;
          });
        },
        onHorizontalDragUpdate: (DragUpdateDetails value){
          setState(() {
            double delta = value.delta.dx;
            posx+= delta;
          });
        },
       
        child:  Stack(
        children: <Widget>[
          Positioned(
            left: posx,
            top: posy,
            child: Container(
              width: boxsize,
              height: boxsize,
              decoration: BoxDecoration(color: Colors.amberAccent, ),
            ),
          )
        ],
      ),),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColorLight,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "tapps: $numtaps - Double taps: $numdoubletaps - long presses :$numlongpress",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
  void center (BuildContext context){
    posx = (MediaQuery.of(context).size.width / 2) - boxsize /2;
    posx = (MediaQuery.of(context).size.height / 2) - boxsize /2 - 30.0;
    setState(() {
      posx = posx;
      posy = posy;
    });
  }
}
