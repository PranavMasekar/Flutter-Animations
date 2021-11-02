import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedPage extends StatefulWidget {
  @override
  _AnimatedPageState createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage>
    with SingleTickerProviderStateMixin {
  // Always dispose your animation

  late AnimationController controller;
  //Animated controller has 0 to 1 value so to change that we create animation variable
  late Animation<double> animation; //To get the values of angle

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    //Giving Curved Animation
    final curvedanimation = CurvedAnimation(
        parent: controller,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut);
    animation =
        //Creating Tween to give starting and ending values
        Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedanimation)
          ..addListener(() {
            //Calling set state for every single value of animation
            setState(() {});
          })
          ..addStatusListener((status) {
            //Adding listener to get current status of animation
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: animation.value,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: Image.asset('assets/profile.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
