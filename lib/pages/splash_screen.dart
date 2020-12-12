import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quoteApp/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  Animation _curves;

  

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _curves =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _colorAnimation =
        ColorTween(begin: Colors.indigo[400], end: Colors.indigo[900])
            .animate(_curves);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 200, end: 300),
        weight: 100,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 300, end: 200),
        weight: 100,
      ),
    ]).animate(_curves);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.forward();

    Timer(Duration(milliseconds: 5000), () {
      Navigator.of(context).push(_createRoute(HomePage(), Offset(1, 0), 500));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: AnimatedBuilder(
          animation: _curves,
          builder: (BuildContext context, _) {
            return Center(
              child: Icon(
                Icons.home,
                color: _colorAnimation.value,
                size: _sizeAnimation.value,
              ),
            );
          }),
    );
  }

  Route _createRoute(Widget _page, Offset _offset, int _duration) {
    return PageRouteBuilder(
      fullscreenDialog: true,
      pageBuilder: (context, animation, secondaryAnimation) => _page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: _offset, end: Offset.zero)
            .chain(CurveTween(curve: Curves.ease));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: _duration),
    );
  }
}
