import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'second_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
              pageBuilder: (context, animation, secondaryanimation) {
                return ListenableProvider(
                  create: (context) => animation,
                  child: SecondPage(),
                );
              },
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
