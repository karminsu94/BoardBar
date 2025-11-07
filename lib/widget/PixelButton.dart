import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PixelButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? fontSize;
  final Function onTap;

  const PixelButton(
      {super.key,
      required this.title,
      required this.width,
      required this.onTap,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(3.w),
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xff335f70),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          border: Border.all(color: const Color(0xff1e3b43), width: 10.w),
        ),
        child: Center(
          child: Text(title,
              textAlign: TextAlign.center,
              style: CustomTextStyle.pressStart2p.copyWith(
                  fontSize: fontSize, color: const Color(0xfff5ddaf))),
        ),
      ),
    );
  }
}
