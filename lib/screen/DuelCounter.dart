import 'dart:math';
import 'dart:math' as math;

import 'package:board_bar/model/Player.dart';
import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:board_bar/widget/BasicCounterCard.dart';
import 'package:board_bar/widget/CountdownTimerWidget.dart';
import 'package:board_bar/widget/TimerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/BasicCounterCardLandscape.dart';
import '../widget/DuelCounterCard.dart';

class DuelCounter extends StatefulWidget {
  @override
  _DuelCounterState createState() => _DuelCounterState();
}

class _DuelCounterState extends State<DuelCounter> {
  List<Player> _playerList = [];
  int initialSecond = 0;
  bool isShowingCountdownTimer = false;
  bool isShowingSubCounter1 = false;
  bool isShowingSubCounter2 = false;
  late List<Color> defaultColorList;
  Map<int, List<Color>> customColorList = {
    0: [Colors.redAccent, Colors.lightBlueAccent],
    1: [Colors.orange, Colors.blueAccent],
    2: [Colors.pinkAccent, Colors.lightGreenAccent],
    3: [
      Colors.yellowAccent,
      Color(0xff6F00FF),
    ],
  };

  final GlobalKey<TimerWidgetState> timerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    defaultColorList = customColorList[math.Random().nextInt(3)]!;
    _playerList.add(
        Player.withColor(name: "🐴", score: 0, color: defaultColorList[0],textureName: 'assets/logo/texture-${Random().nextInt(8)}.png'));
    _playerList.add(
        Player.withColor(name: "🐶", score: 0, color: defaultColorList[1],textureName: 'assets/logo/texture-${Random().nextInt(8)}.png'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      ///设置文字大小不随系统设置改变
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: const Color(0xffaaaaaa),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Transform.rotate(
                    angle: math.pi,
                    child: DuelCounterCard(
                      player: _playerList[0],
                      length: _playerList.length,
                      isShowingSubCounter1: isShowingSubCounter1,
                      isShowingSubCounter2: isShowingSubCounter2,
                      isFlipped: true,
                      callback: () {
                        setState(() {
                          // 更新状态以刷新界面
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: DuelCounterCard(
                    player: _playerList[1],
                    length: _playerList.length,
                    isShowingSubCounter1: isShowingSubCounter1,
                    isShowingSubCounter2: isShowingSubCounter2,
                    isFlipped: false,
                    callback: () {
                      setState(() {
                        // 更新状态以刷新界面
                      });
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 50.w, // 调整位置
              left: MediaQuery.of(context).size.width / 2 - 50.w, // 调整位置
              child: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage('assets/logo/dark-stripes.png'), // 替换为你的透明 PNG 路径, // 替换为你的透明 PNG 路径
                  //   fit: BoxFit.fill, // 根据需要调整背景图片的显示方式
                  //   // repeat: ImageRepeat.repeat, // 设置图片重复铺满
                  // ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [defaultColorList[1], defaultColorList[0]],
                  ),
                  border: Border.all(color: Colors.black54, width: 4.w),
                  borderRadius: BorderRadius.all(
                    Radius.circular(38.r),
                  ),
                ),
                width: 100.w,
                height: 100.w,
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Transform.rotate(
                          angle: math.pi,
                          child: Text(
                            '${_playerList[1].score}',
                            style: CustomTextStyle.pressStart2pShadow.copyWith(
                              fontSize: 17.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: IconButton(
                        onPressed: () {
                          //弹框
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: TextButton(
                                        onPressed: () {
                                          timerKey.currentState?.resetTimer();
                                          setState(() {
                                            for (var player in _playerList) {
                                              player.score = 0;
                                              player.scoreDetail = [];
                                              player.subScore1 = 0;
                                              player.subScore2 = 0;
                                            }
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.restart_alt,
                                          size: 40.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            isShowingCountdownTimer
                                                ? CupertinoColors.activeGreen
                                                : CupertinoColors.inactiveGray,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (isShowingCountdownTimer) {
                                            setState(() {
                                              isShowingCountdownTimer =
                                                  !isShowingCountdownTimer;
                                            });
                                            Navigator.of(context).pop();
                                          } else {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) {
                                                int selectedMinutes = 0;
                                                int selectedSeconds = 0;
                                                return Container(
                                                  height: 500.h,
                                                  color: Colors.white,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 400.h,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  CupertinoPicker(
                                                                itemExtent:
                                                                    32.0,
                                                                onSelectedItemChanged:
                                                                    (int
                                                                        index) {
                                                                  selectedMinutes =
                                                                      index;
                                                                },
                                                                children: List<
                                                                        Widget>.generate(
                                                                    60, (int
                                                                        index) {
                                                                  return Center(
                                                                      child: Text(
                                                                          '$index'));
                                                                }),
                                                              ),
                                                            ),
                                                            Text(":",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        28.sp,
                                                                    color: Colors
                                                                        .black)),
                                                            Expanded(
                                                              child: CupertinoPicker(
                                                                itemExtent: 32.0,
                                                                onSelectedItemChanged: (int index) {
                                                                  selectedSeconds = index * 5;
                                                                },
                                                                children: List<Widget>.generate(
                                                                  12, // 每5秒一个间隔，总共12个选项（0到55秒）
                                                                      (int index) {
                                                                    return Center(
                                                                      child: Text('${index * 5}'),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            initialSecond =
                                                                selectedMinutes *
                                                                        60 +
                                                                    selectedSeconds;
                                                            isShowingCountdownTimer =
                                                                !isShowingCountdownTimer;
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ButtonStyle(
                                                          minimumSize: WidgetStateProperty.all(Size(100.w, 50.h)), // 设置按钮的最小尺寸
                                                          backgroundColor:
                                                              WidgetStateProperty.all(
                                                                  CupertinoColors.activeGreen),
                                                        ),
                                                        child: Text(
                                                          'ok',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 28.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.timer_sharp,
                                          size: 40.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            isShowingSubCounter1
                                                ? CupertinoColors.activeGreen
                                                : CupertinoColors.inactiveGray,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isShowingSubCounter1 =
                                                !isShowingSubCounter1;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.iso,
                                          size: 40.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            isShowingSubCounter2
                                                ? CupertinoColors.activeGreen
                                                : CupertinoColors.inactiveGray,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isShowingSubCounter2 =
                                                !isShowingSubCounter2;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.iso_outlined,
                                          size: 40.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                          timerKey.currentState?.resetTimer();
                          setState(() {
                            for (var player in _playerList) {
                              player.score = 0;
                              player.scoreDetail = [];
                            }
                          });
                        },
                        padding: EdgeInsets.zero, // 移除内边距
                        alignment: Alignment.center,
                        icon: Icon(
                          Icons.settings,
                          size: 25.sp,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${_playerList[0].score}',
                          style: CustomTextStyle.pressStart2pShadow.copyWith(
                            fontSize: 17.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isShowingCountdownTimer)
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 30.h, // 调整位置
                right: 4.w, // 调整位置
                child: CountdownTimerWidget(key: timerKey, initialSecond: initialSecond)
              ),
          ],
        ),
      ),
    );
  }
}
