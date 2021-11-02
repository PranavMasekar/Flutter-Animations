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
        body: RotatingTransition(
      aniamationangle: animation,
      child: ImageAnimation(),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}

//By using animation builder. Animated Builder also increases the performance of app.
class RotatingTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> aniamationangle;

  const RotatingTransition(
      {Key? key, required this.aniamationangle, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: aniamationangle,
      builder: (context, child) {
        return Transform.rotate(
          angle: aniamationangle.value,
          child: child,
        );
      },
      child: child,
    );
  }
}

//Just the widget that the animation should be worked on
class ImageAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(10, 10), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(50),
          color: Colors.deepPurple,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        // child: Image.asset('assets/profile.png'),
      ),
    );
  }
}
