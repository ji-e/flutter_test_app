

import 'package:flutter/material.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';

class CustomLoading extends StatefulWidget {
  @override
  _CustomLoading createState() => _CustomLoading();
}

class _CustomLoading extends State<CustomLoading> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut
    );
    _animation.addListener(() {
      this.setState(() {});
    });
    _controller.repeat();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: ColorUtils.c_55000000,
        child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: Center(
          child:Container(
            height: 50,
            width: 50,
            child: Image.asset('images/logo.png')
        )),
    ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

}

