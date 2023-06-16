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
        vsync: this, duration: Duration(seconds: 4), value: 0.10);
    _controller2 = AnimationController(
        vsync: this, duration: Duration(seconds: 4), value: 0.10);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loop(context, _controller));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loop(context, _controller2));
  }

  Future<void> loop(BuildContext context, controller) async {
    await controller.forward();
    controller.duration = Duration(
      seconds: Random().nextInt(10),
    );
    await controller.reverse();
    controller.duration = Duration(
      seconds: Random().nextInt(10),
    );
    loop(context, controller);
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    _controller2.dispose(); // you need this
    super.dispose();
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
                height: 300,
                child: RotationTransition(
                  turns: _controller2,
                  child: Container(
                    width: 100,
                    color: Colors.red,
                    height: 300,
                  ),
                ),
              ),
            ),
            Container(
              width: 140,
              height: 100,
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
            ),
            Container(
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.redAccent.withOpacity(0.10)),
                    minimumSize:
                        MaterialStateProperty.all<Size>(Size(100, 100)),
                    maximumSize:
                        MaterialStateProperty.all<Size>(Size(100, 100)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
                  onPressed: () {
                    navigateHome(context);
                  },
                  child: Text('LOGIN',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }
}
Future<void> navigateHome(context) async {
  await Future.delayed(Duration.zero, () {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  });
}