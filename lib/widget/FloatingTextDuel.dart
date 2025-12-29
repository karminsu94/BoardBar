import 'dart:math' as Math;

import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingTextDuel extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  final VoidCallback onComplete;
  final bool isMovingUp;
  final bool isFlipped;

  const FloatingTextDuel(
      {super.key,
      required this.text,
      required this.onComplete,
      required this.color,
      required this.fontSize,
      required this.isMovingUp,
      required this.isFlipped});

  @override
  State<FloatingTextDuel> createState() => FloatingTextDuelState();
}

class FloatingTextDuelState extends State<FloatingTextDuel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, widget.isFlipped?(widget.isMovingUp?1:-1):(widget.isMovingUp?-1:1)),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );


    _controller.forward().whenComplete(widget.onComplete);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _positionAnimation,
        child: widget.isFlipped?
        Transform.rotate(
          angle: Math.pi,
          child: SizedBox(
            width: 150.w,
            child: Center(
              child: Text(
                widget.text,
                style: CustomTextStyle.pressStart2p.copyWith(
                  decoration: TextDecoration.none,
                  fontSize: widget.fontSize,
                  color: widget.color,
                ),
              ),
            ),
          ),
        ):
        SizedBox(
          width: 150.w,
          child: Center(
            child: Text(
              widget.text,
              style: CustomTextStyle.pressStart2p.copyWith(
                decoration: TextDecoration.none,
                fontSize: widget.fontSize,
                color: widget.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
