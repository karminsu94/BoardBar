import 'package:board_bar/widget/FloatingTextDuel.dart';
import 'package:board_bar/widget/JumpingMan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/Player.dart';
import '../style/CustomTextStyle.dart';
import 'SimpleCalculator.dart';
import 'package:vibration/vibration.dart';

import 'dart:math';

class SubCounter extends StatefulWidget {
  late Player player;
  late Color textColor;
  late bool isFlipped;
  late int fontSize;
  int type;

  SubCounter({
    super.key,
    required this.player,
    required this.textColor,
    required this.isFlipped,
    required this.fontSize,
    required this.type,
  });

  @override
  State<SubCounter> createState() => _SubCounterState();
}

class _SubCounterState extends State<SubCounter> with SingleTickerProviderStateMixin {
  bool _hasSwipedDown = false;


  void _showFloatingText(BuildContext context, String text, Color color,
      double fontSize, double positionParma, bool isMovingUp, bool isFlipped) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    // 如果组件被翻转，需要调整坐标
    final screenHeight = MediaQuery.of(context).size.height;
    final adjustedPosition = widget.isFlipped
        ? Offset(position.dx, screenHeight - position.dy - renderBox.size.height)
        : position;
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy,
        left: isFlipped ?
        adjustedPosition.dx - renderBox.size.width - 50.w
            : position.dx - renderBox.size.width + 5.w,
        // left: isFlipped ? adjustedPosition.dx  : position.dx - renderBox.size.width/positionParma,
        // right: isFlipped ?  : null,
        child: FloatingTextDuel(
          text: text,
          color: color,
          fontSize: fontSize,
          isMovingUp: isMovingUp,
          isFlipped: isFlipped,
          onComplete: () {
            overlayEntry?.remove();
            overlayEntry = null;
          },
        ),
      ),
    );

    overlay.insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(()  {
          if(widget.type == 1){
            widget.player.subScore1 = widget.player.subScore1 + 1;
          }else if(widget.type == 2){
            widget.player.subScore2 = widget.player.subScore2 + 1;
          }
        });
        _showFloatingText(
            context, "+1", Colors.deepOrangeAccent, 20.sp, 2, true, widget.isFlipped);
      },
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0.4 && !_hasSwipedDown) {
          // 检测下滑操作
          setState(() {
            if(widget.type == 1){
              widget.player.subScore1 = widget.player.subScore1 - 1;
            }else if(widget.type == 2){
              widget.player.subScore2 = widget.player.subScore2 - 1;
            }
          });
          _hasSwipedDown = true;
          _showFloatingText(
              context, "-1", Colors.white, 20.sp, 2, false, widget.isFlipped);
        }
      },
      onVerticalDragEnd: (details) {
        _hasSwipedDown = false; // 重置标志，允许下一次下滑操作
      },

      child: Expanded(
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Text('${widget.type == 1 ? widget.player.subScore1 : widget.player.subScore2}',
                style: CustomTextStyle.pressStart2p
                    .copyWith(
                    fontSize: widget.player.subScore1.toString()
                        .length >= 3
                        ? widget.fontSize.sp
                        : (widget.fontSize+4).sp,
                    color: widget.textColor)),
          ),
        ),
      ),
    );
  }

}
