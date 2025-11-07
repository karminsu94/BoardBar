import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/Player.dart';
import '../style/CustomTextStyle.dart';
import 'FloatingText.dart';
import 'SimpleCalculator.dart';

import 'dart:math';

class BasicCounterCard extends StatefulWidget {
  late Player player;
  late int length;
  Function callback;

  BasicCounterCard({
    super.key,
    required this.player,
    required this.callback,
    required this.length,
  });

  @override
  State<BasicCounterCard> createState() => _BasicCounterCardState();
}

class _BasicCounterCardState extends State<BasicCounterCard> {
  bool _hasSwipedDown = false;
  bool _hasSwipedUp = false;
  bool _hasSwipedLeft = false;
  int historyLength = 7;
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
        child: Stack(
          children: [
            Positioned(
              top: 15.h,
              right: 70.w,
              bottom: 0,
              child: Container(
                  width: 45.w,
                  height: 23.h,
                  decoration: BoxDecoration(
                      // border: Border.all(width: 3.w, color: Colors.black)
                      // color: const Color(0xff233c4c),
                      // borderRadius: BorderRadius.circular(10),
                      ),
                  child: widget.player.scoreDetail.isEmpty?null:AnimatedList(
                    key: _animatedListKey,
                    initialItemCount:
                        widget.player.scoreDetail.length >= historyLength
                            ? historyLength
                            : widget.player.scoreDetail.length,
                    itemBuilder: (context, index, animation) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween<Offset>(
                            begin: const Offset(2, 0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: Text(
                          widget.player.scoreDetail.length >= historyLength
                              ? widget.player.scoreDetail[index +
                                  widget.player.scoreDetail.length -
                                  historyLength]
                              : widget.player.scoreDetail[index],
                          style: CustomTextStyle.pressStart2pShadow.copyWith(
                            fontSize: 10.sp,
                            color: Colors.amberAccent,
                          ),
                        ),
                      );
                    },
                  )
                  // child: ListView.builder(
                  //   itemCount: widget.player.scoreDetail.length > historyLength
                  //       ? historyLength
                  //       : widget.player.scoreDetail.length, // 固定最多显示7个
                  //   itemBuilder: (context, index) {
                  //     // 如果列表长度大于7，显示最后的7个
                  //     final displayIndex =
                  //         widget.player.scoreDetail.length > historyLength
                  //             ? widget.player.scoreDetail.length -
                  //                 historyLength +
                  //                 index
                  //             : index;
                  //     return Container(
                  //       margin: EdgeInsets.only(bottom: 2.h),
                  //       child: AnimatedSwitcher(
                  //         duration: const Duration(milliseconds: 1000),
                  //         transitionBuilder:
                  //             (Widget child, Animation<double> animation) {
                  //           return ScaleTransition(
                  //             scale: animation, child: child);
                  //         },
                  //         child: Text(
                  //           widget.player.scoreDetail[displayIndex],
                  //           key: ValueKey(
                  //               widget.player.scoreDetail[displayIndex]),
                  //           style: CustomTextStyle.pressStart2pShadow.copyWith(
                  //             fontSize: 10.sp,
                  //             color: Colors.amberAccent,
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // )
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.player.score = widget.player.score - 10;
                            widget.player.scoreDetail.add("-10");
                            updateAnimatedList(historyLength);
                          });
                          _showFloatingText(context, "-10", Colors.black87,
                              35.sp, 2.5, false);
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 15.w, bottom: 5.w, left: 10.w),
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff335f70),
                            border: Border.all(
                                color: const Color(0xff1e3b43), width: 5.w),
                          ),
                          child: Center(
                            child: Text("-10",
                                style: CustomTextStyle.pressStart2p.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp,
                                    color: const Color(0xfff5ddaf))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.player.score = widget.player.score - 5;
                            widget.player.scoreDetail.add("-5");
                            updateAnimatedList(historyLength);
                          });
                          _showFloatingText(
                              context, "-5", Colors.black87, 28.sp, 2.3, false);
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 5.w, bottom: 5.w, left: 10.w),
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff335f70),
                            border: Border.all(
                                color: const Color(0xff1e3b43), width: 5.w),
                          ),
                          child: Center(
                            child: Text("-5",
                                style: CustomTextStyle.pressStart2p.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp,
                                    color: const Color(0xfff5ddaf))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.player.score = widget.player.score + 1;
                      widget.player.scoreDetail.add("+1");
                      updateAnimatedList(historyLength);
                    });
                    _showFloatingText(
                        context, "+1", Colors.amberAccent, 20.sp, 2.3, true);
                  },
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0.4 && !_hasSwipedDown) {
                      // 检测下滑操作
                      setState(() {
                        widget.player.score = widget.player.score - 1;
                        widget.player.scoreDetail.add("-1");
                        updateAnimatedList(historyLength);
                      });
                      _hasSwipedDown = true;
                      _showFloatingText(
                          context, "-1", Colors.black87, 25.sp, 2.3, false);
                    }
                    // if (details.delta.dy < -0.4 && !_hasSwipedUp) {
                    //   // 检测上滑操作
                    //   setState(() {
                    //     // 如果scoreDetail不为空，才允许上滑
                    //     if (widget.scoreDetail.isNotEmpty) {
                    //       int latestValue = int.parse(widget
                    //           .scoreDetail[widget.scoreDetail.length - 1]);
                    //       widget.score = widget.score - latestValue;
                    //       widget.scoreDetail.removeLast();
                    //       _hasSwipedUp = true;
                    //     }
                    //   });
                    // }
                  },
                  onVerticalDragEnd: (details) {
                    _hasSwipedDown = false; // 重置标志，允许下一次下滑操作
                    _hasSwipedUp = false; // 重置标志，允许下一次上滑操作
                  },
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx < -0.2 && !_hasSwipedLeft) {
                      // 检测左滑操作
                      if (widget.player.scoreDetail.isNotEmpty) {
                        setState(() {
                          // 如果scoreDetail不为空，才允许上滑
                          int latestValue = int.parse(widget.player.scoreDetail[
                              widget.player.scoreDetail.length - 1]);
                          widget.player.score =
                              widget.player.score - latestValue;
                          widget.player.scoreDetail.removeLast();
                          _hasSwipedLeft = true;

                          // 如果列表长度超过历史长度，移除最新的项,并在头部插入就数据
                          // 否则直接移除最后一项
                          if (widget.player.scoreDetail.length >
                              historyLength) {
                            // 列表的尾删除新项
                            _animatedListKey.currentState?.removeItem(
                              historyLength - 1,
                              (context, animation) => SizedBox.shrink(),
                            );
                            // 再在列表的头插入旧项
                            _animatedListKey.currentState?.insertItem(0);
                          } else {
                            _animatedListKey.currentState?.removeItem(
                              0,
                              (context, animation) => SizedBox.shrink(),
                            );
                          }
                        });
                        _showFloatingText(
                            context, "↩", Colors.white70, 25.sp, 2.3, false);
                      }
                    }
                  },
                  onHorizontalDragEnd: (details) {
                    _hasSwipedLeft = false; // 重置标志，允许下一次左滑操作
                  },
                  onLongPress: () async {
                    int calculatedScore = widget.player.score;
                    List<String> calculatedDetail = widget.player.scoreDetail;

                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.8, // 设置高度为屏幕的80%
                          child: SimpleCalculator(
                            score: calculatedScore,
                            scoreDetail: calculatedDetail,
                            callback: (int cScore, List<String> cScoreDetail) {
                              calculatedScore = cScore;
                              calculatedDetail = cScoreDetail;
                            },
                          ),
                        );
                      },
                    );

                    setState(() {
                      widget.player.score = calculatedScore;
                      widget.player.scoreDetail = calculatedDetail;
                    });
                  },
                  child: Container(
                    width: 280.w,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onLongPress: () async {
                            var textEditingController =
                                TextEditingController(text: widget.player.name);
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
                                                widget.player.name = inputName;
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
                                            widget.callback(widget.player);
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
                            widget.player.name,
                            style: CustomTextStyle.xiangjiaoShadow.copyWith(

                              fontSize: 25.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "${widget.player.score}",
                          style: widget.length<=2?
                          CustomTextStyle.pressStart2pShadow.copyWith(fontSize: 75.sp):
                              CustomTextStyle.pressStart2pShadow,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.player.score = widget.player.score + 10;
                            widget.player.scoreDetail.add("+10");

                            updateAnimatedList(historyLength);
                          });
                          _showFloatingText(context, "+10", Colors.yellowAccent,
                              35.sp, 2.5, true);
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 15.w, bottom: 5.w, right: 10.w),
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff335f70),
                            border: Border.all(
                                color: const Color(0xff1e3b43), width: 5.w),
                          ),
                          child: Center(
                            child: Text("+10",
                                style: CustomTextStyle.pressStart2p.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp,
                                    color: const Color(0xfff5ddaf))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.player.score = widget.player.score + 5;
                            widget.player.scoreDetail.add("+5");
                            updateAnimatedList(historyLength);
                          });
                          _showFloatingText(
                              context, "+5", Colors.yellow, 28.sp, 2.3, true);
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 5.w, bottom: 5.w, right: 10.w),
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff335f70),
                            border: Border.all(
                                color: const Color(0xff1e3b43), width: 5.w),
                          ),
                          child: Center(
                            child: Text("+5",
                                style: CustomTextStyle.pressStart2p.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp,
                                    color: const Color(0xfff5ddaf))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void updateAnimatedList(int historyLength) {
    // 如果列表长度超过历史长度，移除最旧的项
    if (widget.player.scoreDetail.length > historyLength) {
      _animatedListKey.currentState?.removeItem(
        0,
        (context, animation) => SizedBox.shrink(),
      );
      // 在列表的末尾插入新项
      _animatedListKey.currentState?.insertItem(historyLength - 1);
    } else {
      // 在列表的末尾插入新项
      _animatedListKey.currentState
          ?.insertItem(widget.player.scoreDetail.length - 1);
    }
  }
}
