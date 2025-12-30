import 'package:board_bar/widget/FloatingTextDuel.dart';
import 'package:board_bar/widget/JumpingMan.dart';
import 'package:board_bar/widget/SubCounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/Player.dart';
import '../style/CustomTextStyle.dart';
import 'SimpleCalculator.dart';
import 'package:vibration/vibration.dart';
// import 'package:audioplayers/audioplayers.dart';

import 'dart:math';

class DuelCounterCard extends StatefulWidget {
  late Player player;
  late int length;
  late bool isFlipped;
  late bool isShowingSubCounter1;
  late bool isShowingSubCounter2;
  Function callback;


  DuelCounterCard({
    super.key,
    required this.player,
    required this.length,
    required this.isFlipped,
    required this.callback,
    required this.isShowingSubCounter1,
    required this.isShowingSubCounter2,
  });

  @override
  State<DuelCounterCard> createState() => _DuelCounterCardState();
}

class _DuelCounterCardState extends State<DuelCounterCard> with SingleTickerProviderStateMixin {
  bool _hasSwipedDown = false;
  bool _hasSwipedUp = false;
  bool _hasSwipedLeft = false;
  // final player = AudioPlayer();

  int historyLength = 7;
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  late AnimationController _jumpingManController;

  @override
  void initState() {
    super.initState();
    _jumpingManController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _jumpingManController.dispose();
    super.dispose();
  }


  void _showFloatingText(BuildContext context, String text, Color color,
      double fontSize, double positionParma, bool isMovingUp, bool isFlipped) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy-10.h,
        left: isFlipped ? null : 135.w,
        right: isFlipped ? 135.w : null,
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
    return Container(
        height: 150.w,
        decoration: BoxDecoration(
          // color: const Color(0xffb44f33),
          color: widget.player.color,
          image: DecorationImage(
            image: AssetImage(widget.player.textureName!), // 替换为你的透明 PNG 路径, // 替换为你的透明 PNG 路径
            fit: BoxFit.none, // 根据需要调整背景图片的显示方式
            repeat: ImageRepeat.repeat, // 设置图片重复铺满
          )
          // borderRadius: BorderRadius.all(Radius.circular(10)),

        ),
        child: Stack(
          // clipBehavior: Clip.none, // 允许子组件超出父组件边界
          children: [
            // 历史记录显示区域
            Positioned(
              top: 15.h,
              right: 95.w,
              bottom: 0,
              child: Container(
                  width: 45.w,
                  height: 23.h,
                  decoration: BoxDecoration(
                      // border: Border.all(width: 3.w, color: Colors.black)
                      // color: const Color(0xff233c4c),
                      // borderRadius: BorderRadius.circular(10),
                      ),
                  child: widget.player.scoreDetail.isEmpty
                      ? null
                      : AnimatedList(
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
                                widget.player.scoreDetail.length >=
                                        historyLength
                                    ? widget.player.scoreDetail[index +
                                        widget.player.scoreDetail.length -
                                        historyLength]
                                    : widget.player.scoreDetail[index],
                                style:
                                    CustomTextStyle.pressStart2pShadow.copyWith(
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
            Stack(
              children: [
                GestureDetector(
                  onTap: ()  {
                    setState(() {
                      widget.player.score = widget.player.score + 1;
                      widget.callback();
                      widget.player.scoreDetail.add("+1");

                      updateAnimatedList(historyLength);
                      _jumpingManController.forward(from: 0.0);
                    });
                    _showFloatingText(context, "+1", Colors.amberAccent, 20.sp,
                        2.3, true, widget.isFlipped);
                    // await player.play(AssetSource('assets/logo/score.mp3'));
                  },
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0.4 && !_hasSwipedDown) {
                      // 检测下滑操作
                      setState(() {
                        widget.player.score = widget.player.score - 1;
                        widget.player.scoreDetail.add("-1");
                        widget.callback();
                        updateAnimatedList(historyLength);
                      });
                      _hasSwipedDown = true;
                      _showFloatingText(context, "-1", Colors.black87, 25.sp,
                          2.3, false, widget.isFlipped);
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
                          widget.callback();
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
                        _showFloatingText(context, "↩", Colors.white70, 25.sp,
                            2.3, false, widget.isFlipped);
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
                      widget.callback();
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        // width: 225.w,
                        height: 250.h,
                        color: Colors.transparent,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "${widget.player.score}",
                          style: widget.player.score < 100
                              ? CustomTextStyle.pressStart2pShadow
                                  .copyWith(fontSize: 75.sp)
                              : CustomTextStyle.pressStart2pShadow
                                  .copyWith(fontSize: 60.sp),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: 225.w,
                          color: Colors.transparent,
                          child: JumpingMan(
                            img: 'assets/logo/dog-sleeping.png',
                            imgJumping1: 'assets/logo/dog-jumping1.png',
                            imgJumping2: 'assets/logo/dog-jumping2.png',
                            isFlipped: widget.isFlipped,
                            externalController: _jumpingManController,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 225.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (widget.isShowingSubCounter1)
                              Container(
                                  width: 65.w,
                                  height: 65.w,
                                  margin: EdgeInsets.only(bottom: 20.h),
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      border: Border.all(
                                          color: Colors.white70, width: 5.w),
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: SubCounter(
                                    player: widget.player,
                                    textColor: Colors.white70,
                                    isFlipped: widget.isFlipped,
                                    fontSize: 18,
                                    type: 1,
                                  )),
                            if (widget.isShowingSubCounter2)
                              Container(
                                  width: 65.w,
                                  height: 65.w,
                                  margin: EdgeInsets.only(bottom: 20.h),
                                  decoration: BoxDecoration(
                                      color: Colors.white70,
                                      border: Border.all(
                                          color: Colors.black87, width: 5.w),
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: SubCounter(
                                    player: widget.player,
                                    textColor: Colors.black87,
                                    isFlipped: widget.isFlipped,
                                    fontSize: 18,
                                    type: 2,
                                  )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  //top和bottom为0,让其占据父组件的全部高度
                  top: 0,
                  bottom: 0,
                  left: 5.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.player.score = widget.player.score - 10;
                              widget.player.scoreDetail.add("-10");
                              updateAnimatedList(historyLength);
                              widget.callback();
                            });
                            _showFloatingText(context, "-10", Colors.black87,
                                35.sp, 2.5, false, widget.isFlipped);
                          },
                          child: Image.asset(
                            'assets/logo/min10.png', // 替换为你的图片路径
                            fit: BoxFit.fitWidth,
                            width: 100.w,
                            opacity: AlwaysStoppedAnimation(0.9),
                          )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.player.score = widget.player.score - 5;
                            widget.player.scoreDetail.add("-5");
                            updateAnimatedList(historyLength);
                            widget.callback();
                          });
                          _showFloatingText(context, "-5", Colors.black87,
                              28.sp, 2.3, false, widget.isFlipped);
                        },
                        child: Image.asset(
                          'assets/logo/min5.png', // 替换为你的图片路径
                          width: 100.w,
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  //top和bottom为0,让其占据父组件的全部高度
                  top: 0,
                  bottom: 0,
                  right: 5.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            if (await Vibration.hasVibrator()) {
                              Vibration.vibrate();
                            }
                            setState(() {
                              widget.player.score = widget.player.score + 10;
                              widget.player.scoreDetail.add("+10");
                              widget.callback();
                              updateAnimatedList(historyLength);
                            });
                            _showFloatingText(context, "+10", Colors.yellowAccent, 35.sp, 2.5, true, widget.isFlipped);
                          },
                          child: Image.asset(
                            width: 100.w,
                            'assets/logo/plus10.png', // 替换为你的图片路径
                            fit: BoxFit.fitWidth,
                          )),
                      GestureDetector(
                        onTap: () async {
                          if (await Vibration.hasVibrator()) {
                            Vibration.vibrate();
                          }
                          setState(() {
                            widget.player.score = widget.player.score + 5;
                            widget.player.scoreDetail.add("+5");
                            updateAnimatedList(historyLength);
                            widget.callback();
                          });
                          _showFloatingText(context, "+5", Colors.yellow, 28.sp, 2.3, true, widget.isFlipped);
                        },
                        child: Image.asset(
                          'assets/logo/plus5.png',
                          width: 100.w,// 替换为你的图片路径
                          fit: BoxFit.fitWidth,
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
