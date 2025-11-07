import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PixelBorderPainter extends CustomPainter {
  final double pixel = 3.w; // 单位像素大小，可调

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff1e3b43) // 边框颜色
      ..style = PaintingStyle.stroke
      ..strokeWidth = pixel;

    final path = Path();

    // 从左上角开始，顺时针绘制，包含内凹像素角处理
    path.moveTo(0, pixel); // 左上凹进去
    path.lineTo(0, size.height - pixel); // 左边
    path.lineTo(0 + pixel, size.height); // 左下凹进去
    path.lineTo(size.width - pixel, size.height); // 下边
    path.lineTo(size.width, size.height - pixel); // 右下凹进去
    path.lineTo(size.width, pixel); // 右边
    path.lineTo(size.width - pixel, 0); // 右上凹进去
    path.lineTo(pixel, 0); // 上边
    path.close(); // 回到 (0, pixel)

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
