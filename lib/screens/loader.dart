

import 'package:flutter/material.dart';
import 'package:yet_another_mal_client/screens/home.dart';
import 'dart:math';

class Loader extends StatefulWidget {
  const Loader();
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: 5), value: 0.10);

    WidgetsBinding.instance.addPostFrameCallback(
            (_) => loop(context)
            );
  }
  Future<void> loop(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await _controller.forward();
    _controller.duration = Duration(seconds: Random().nextInt(10),);
    await Future.delayed(Duration(seconds: 1));
    await _controller.reverse();
    _controller.duration = Duration(seconds: Random().nextInt(10),);
    loop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 48, 48, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RotationTransition(
              turns: _controller,
              child: Container(
                width: 100,
                color: Colors.redAccent,
                height: 400,
                child:  RotationTransition(
                  turns: _controller,
                  child: Container(
                    width: 100,
                    color: Colors.red,
                    height: 400,),
                ),
              ),
            ),
            Container(
              width: 140,
              height: 140,
              padding: const EdgeInsets.only(top: 20.0),
              child:  Image.asset("assets/images/logo.png", fit: BoxFit.contain),
            ),
            Container(
              child: TextButton(
                style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent.withOpacity(0.10)),
                  minimumSize: MaterialStateProperty.all<Size>(Size(100,100)),
                  maximumSize: MaterialStateProperty.all<Size>(Size(100,100)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Colors.red.withOpacity(0.04);
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed))
                        return Colors.red.withOpacity(0.12);
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                onPressed: () { navigateHome();},
                child: Text('LOGIN',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> navigateHome() async{
      await Future.delayed(Duration.zero, () {
        Navigator.push(context,MaterialPageRoute(builder: (context) =>
        const HomeScreen()
        ));
      });
  }
}