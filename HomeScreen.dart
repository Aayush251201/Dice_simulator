import 'package:flutter/material.dart';
import 'dart:math';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int left_dice = 1;
  int right_dice = 1;
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          left_dice = Random().nextInt(6) + 1;
          right_dice = Random().nextInt(6) + 1;
        });
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice-E'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Image(
                        height: 200 - (_controller.value) * 200,
                        image: AssetImage('Assets/images/dice-$left_dice.png')),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                          height: 200 - (_controller.value) * 200,
                          image: AssetImage(
                              'Assets/images/dice-$right_dice.png'))),
                ))
              ],
            ),
            Container(
              margin: EdgeInsets.all(30),
              width: 500.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: roll,
                child: Text(
                  'ROLL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
