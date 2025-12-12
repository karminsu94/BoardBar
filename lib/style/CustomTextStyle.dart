import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyle {
  static final TextStyle pressStart2pShadow = TextStyle(
    fontFamily: 'PressStart2P',
    fontWeight: FontWeight.w900,
    fontSize: 40.sp,
    color: const Color(0xfff5ddaf),
    shadows: [
      const Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black26,
      ),
    ],
  );

  static final TextStyle pressStart2p = TextStyle(
    fontFamily: 'PressStart2P',
    fontWeight: FontWeight.w900,
    fontSize: 25.sp,
    color: Colors.black87,
  );

  static final TextStyle xiangjiaoShadow = TextStyle(
    fontFamily: 'PressStart2P',
    fontWeight: FontWeight.w900,
    fontSize: 40.sp,
    color: const Color(0xfff5ddaf),
    shadows: [
      const Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black26,
      ),
    ],
  );

  static final TextStyle xiangjiao = TextStyle(
    fontFamily: 'PressStart2P',
    fontWeight: FontWeight.w900,
    fontSize: 25.sp,
    color: Colors.black87,
  );
}