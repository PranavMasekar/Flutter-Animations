import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SlidingContainer(
              color: Colors.red,
              intervalend: 0.5,
              initialOffsetX: 1,
              intervalstart: 0,
            ),
          ),
          Expanded(
            child: SlidingContainer(
              color: Colors.green,
              intervalend: 1,
              initialOffsetX: -1,
              intervalstart: 0.5,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: Text('Navigate back'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SlidingContainer extends StatelessWidget {
  final double initialOffsetX;
  final double intervalstart;
  final double intervalend;
  final Color color;

  const SlidingContainer(
      {Key? key,
      required this.initialOffsetX,
      required this.intervalstart,
      required this.intervalend,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(initialOffsetX, 0),
            end: Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(
                intervalstart,
                intervalend,
                curve: Curves.easeOutCubic,
              ),
            ),
          ),
          child: child,
        );
      },
      child: Container(
        color: color,
      ),
    );
  }
}
