import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/Player.dart';
import '../model/ScriptRecord.dart';
import '../style/CustomTextStyle.dart';
import 'FloatingText.dart';
import 'SimpleCalculator.dart';

import 'dart:math';

class CustomCounterPlayerCard extends StatefulWidget {
  late ScriptRecord scriptRecord;
  Function callback;

  CustomCounterPlayerCard({
    super.key,
    required this.scriptRecord,
    required this.callback,
  });

  @override
  State<CustomCounterPlayerCard> createState() => _CustomCounterPlayerCardState();
}

class _CustomCounterPlayerCardState extends State<CustomCounterPlayerCard> {
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  Color _randomColor = Color(0xFF000000 + Random().nextInt(0x00FFFFFF));

  void _showFloatingText(BuildContext context, String text, Color color,
      double fontSize, double positionParma, bool isMovingUp) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: isMovingUp
            ? position.dy
            : position.dy + renderBox.size.height * 4 / 5,
        left: position.dx + renderBox.size.width / positionParma,
        child: FloatingText(
          text: text,
          color: color,
          fontSize: fontSize,
          isMovingUp: isMovingUp,
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
    return Container(
        height: 150.w,
        decoration: BoxDecoration(
          // color: const Color(0xffb44f33),
          color: _randomColor,
          // borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                   Container(
                    width: 280.w,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onLongPress: () async {
                            var textEditingController =
                                TextEditingController(text: widget.scriptRecord.playerName);
                            String inputName = '';
                            Color selectedColor = _randomColor;

                            await showModalBottomSheet(
                              context: context,
                              backgroundColor: const Color(0xfff9e0b2), // 设置背景色
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 480.h,
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('添加玩家名称',
                                            style:
                                                CustomTextStyle.xiangjiao),
                                        SizedBox(height: 35.h),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff233c4c),
                                                  width: 8.w),
                                              color: Colors.white70),
                                          width: 350.w,
                                          child: TextField(
                                            controller: textEditingController,
                                            textAlign: TextAlign.center,
                                            onChanged: (value) {
                                              setState(() {
                                                inputName = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: '请输入名称',
                                                hintStyle: CustomTextStyle
                                                    .pressStart2p
                                                    .copyWith(
                                                  fontSize: 20.sp,
                                                )),
                                            style: CustomTextStyle.xiangjiao
                                                .copyWith(
                                                    fontSize: 20.sp,
                                                    fontWeight: null),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('选择颜色'),
                                                  content: SingleChildScrollView(
                                                    child: ColorPicker(
                                                      pickerColor: selectedColor,
                                                      onColorChanged: (Color color) {
                                                        setState(() {
                                                          selectedColor = color;
                                                        });
                                                      },
                                                      showLabel: true,
                                                      pickerAreaHeightPercent: 0.8,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('确定'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );


                                            // setState(() {
                                            //   selectedColor = Color(
                                            //       (0xFF000000 +
                                            //               Random().nextInt(
                                            //                   0x00FFFFFF))
                                            //           .toInt());
                                            // });
                                          },
                                          child: Container(
                                              width: 40.w,
                                              height: 40.w,
                                              decoration: BoxDecoration(
                                                color: selectedColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.r),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xff1e3b43),
                                                    width: 5.w),
                                              )),
                                        ),
                                        SizedBox(height: 35.h),
                                        TextButton(
                                          child: Text(
                                            '确定',
                                            style: CustomTextStyle.xiangjiao,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (inputName.isNotEmpty) {
                                                widget.scriptRecord.playerName = inputName;
                                              }
                                              _randomColor = selectedColor;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        SizedBox(height: 15.h),
                                        TextButton(
                                          child: Text(
                                            '删除',
                                            style: CustomTextStyle.xiangjiao,
                                          ),
                                          onPressed: () {
                                            widget.callback(widget.scriptRecord);
                                            Navigator.of(context).pop(); // 关闭弹窗
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                            );

                            setState(() {});

                          },
                          child: Text(
                            widget.scriptRecord.playerName,
                            style: CustomTextStyle.xiangjiaoShadow.copyWith(

                              fontSize: 25.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        );
  }
}
