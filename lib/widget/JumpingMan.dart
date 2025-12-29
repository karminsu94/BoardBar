import 'dart:math' as Math;

import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JumpingMan extends StatefulWidget {
  final String img;
  final String imgJumping1;
  final String imgJumping2;
  final bool isFlipped;
  final AnimationController? externalController; // 外部控制器

  const JumpingMan({
    super.key,
    required this.img,
    required this.imgJumping1,
    required this.imgJumping2,
    required this.isFlipped,
    this.externalController, // 可选的外部控制器
  });

  @override
  State<JumpingMan> createState() => JumpingManState();
}

class JumpingManState extends State<JumpingMan>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  bool _isJumpingImage1 = true; // 记录当前显示的图片

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // 如果提供了外部控制器，则同步控制器
    widget.externalController?.addStatusListener((status) {
      if (_controller.isAnimating) {
        _controller.stop();
      }
      _controller.reset();

      if (status == AnimationStatus.forward) {
        _controller.forward();
        _isJumpingImage1 = !_isJumpingImage1; // 切换图片
      } else if (status == AnimationStatus.reverse) {
        _controller.reverse();
        _isJumpingImage1 = !_isJumpingImage1; // 切换图片
      }


    });

    _positionAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(0, 0), // 起始位置保持原点
          end: Offset(0, -0.3), // 向上跳起
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(0, -0.3), // 从跳起的最高点
          end: Offset(0, 0), // 回到原点
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 2,
      ),
    ]).animate(_controller);

    // 监听动画状态
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        setState(() {}); // 触发重建以切换回 img
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _isJumpingImage1 = !_isJumpingImage1; // 切换图片
    // });
    return SlideTransition(
      position: _positionAnimation,
      child: Container(
        alignment: Alignment.topCenter,
        child: Image.asset(
          _controller.status == AnimationStatus.forward ||
                  _controller.status == AnimationStatus.reverse
              ? (_isJumpingImage1
                  ? widget.imgJumping1
                  : widget.imgJumping2) // 根据点击切换图片
              : widget.img, // 动态切换图片
          fit: BoxFit.contain,
          width: 75.w,
        ),
      ),
    );
  }
} // 外部控制器
