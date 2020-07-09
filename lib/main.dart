import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyHome());
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loader(),
    );
  }
}

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 1));
    _animation = Tween(begin: 1.0,end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.repeat(
      reverse: true
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(animation: _controller, builder: (context,widget){
        return Center(
        child: Transform.rotate(
          angle:_controller.status == AnimationStatus.forward ? (math.pi * 2) * _controller.value:-(math.pi * 2) * _controller.value,
                  child: Container(
            height: 90.0,
            width: 90.0,
            child: CustomPaint(
              painter: LoaderCanvas(
                radius: _animation.value
              ),
            ),
          ),
        ),
      );
      })
    );
  }
}

class LoaderCanvas extends CustomPainter {

  double radius;
  LoaderCanvas({this.radius});

  


  @override
  void paint(Canvas canvas, Size size) {
    Paint _arc = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Paint _circle = Paint()
      ..color = Colors.grey[300]
      ..style = PaintingStyle.fill;
     

    Offset _center = Offset(size.width / 2, size.height / 2);

    

    canvas.drawCircle(_center, size.width/2, _circle);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center, width: size.width * radius, height: size.height*radius),
        math.pi / 4,
        math.pi / 2,
        false,
        _arc);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center, width: size.width* radius, height: size.height* radius),
        -math.pi / 4,
        -math.pi / 2,
        false,
        _arc);
  }

  @override
  bool shouldRepaint(LoaderCanvas oldPaint) {
    return true;
  }
}
