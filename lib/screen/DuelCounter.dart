import 'dart:math';
import 'dart:math' as math;

import 'package:board_bar/model/Player.dart';
import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:board_bar/widget/BasicCounterCard.dart';
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
  TimerWidget? _timerWidget;
  bool isShowingSubCounter1 = false;
  bool isShowingSubCounter2 = false;
  late List<Color> defaultColorList;
  Map<int,List<Color>> customColorList = {
    0: [Colors.redAccent, Colors.lightBlueAccent],
    1: [Colors.orange, Colors.blueAccent],
    2: [Color(0xffC54B8C), Colors.lightGreenAccent],
    3: [Colors.yellowAccent, Color(0xff6F00FF),],
  };
  var textureNum = Random().nextInt(8);

  final GlobalKey<TimerWidgetState> timerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    _timerWidget = TimerWidget(key: timerKey);
    defaultColorList = customColorList[math.Random().nextInt(3)]!;
    _playerList.add(
        Player.withColor(name: "🐴", score: 0, color: defaultColorList[0]));
    _playerList.add(
        Player.withColor(name: "🐶", score: 0, color: defaultColorList[1]));
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
                      initialColor: defaultColorList[0],
                      textureRandomNum: textureNum,
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
                    initialColor: defaultColorList[1],
                    textureRandomNum: textureNum,
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
              top: MediaQuery.of(context).size.height / 2 - 50, // 调整位置
              left: MediaQuery.of(context).size.width / 2 - 50, // 调整位置
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
                    Radius.circular(50.r),
                  ),
                ),
                width: 100,
                height: 100,
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
                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                      child: TextButton(
                                        onPressed: () {
                                          timerKey.currentState?.resetTimer();
                                          setState(() {
                                            for (var player in _playerList) {
                                              player.score = 0;
                                              player.scoreDetail = [];
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
                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateProperty.all(
                                            isShowingSubCounter1 ? CupertinoColors.activeGreen : CupertinoColors.inactiveGray,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isShowingSubCounter1 = !isShowingSubCounter1;
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
                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateProperty.all(
                                            isShowingSubCounter2 ? CupertinoColors.activeGreen : CupertinoColors.inactiveGray,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isShowingSubCounter2 = !isShowingSubCounter2;
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
                          size: 18.sp,
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
          ],
        ),
      ),
    );
  }
}
