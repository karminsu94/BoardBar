import 'dart:math';

import 'package:board_bar/model/Player.dart';
import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:board_bar/widget/BasicCounterCard.dart';
import 'package:board_bar/widget/CountdownTimerWidget.dart';
import 'package:board_bar/widget/TimerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicCounter extends StatefulWidget {
  @override
  _BasicCounterState createState() => _BasicCounterState();
}

class _BasicCounterState extends State<BasicCounter> {
  List<Player> _playerList = [];
  TimerWidget? _timerWidget;
  int initialSecond = 0;
  List<Color> defaultColorList = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.redAccent,
    Colors.deepPurple,
    Colors.yellow,
    Colors.brown,
    Colors.cyan,
  ];

  bool isShowingTimer = false;
  bool isShowingCountdownTimer = false;
  bool isShowingSubCounter1 = false;
  bool isShowingSubCounter2 = false;

  final GlobalKey<TimerWidgetState> timerKey = GlobalKey();

  final GlobalKey<CountdownTimerWidgetState> countdownTimerKey = GlobalKey();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    _timerWidget = TimerWidget(key: timerKey);

    _playerList.add(Player.withColor(
        name: "🐴",
        score: 0,
        color: defaultColorList[0],
        textureName: 'assets/logo/texture-${Random().nextInt(8)}.png'));
    _playerList.add(Player.withColor(
        name: "🐶",
        score: 0,
        color: defaultColorList[1],
        textureName: 'assets/logo/texture-${Random().nextInt(8)}.png'));
    _playerList.add(Player.withColor(
        name: "🐒",
        score: 0,
        color: defaultColorList[2],
        textureName: 'assets/logo/texture-${Random().nextInt(8)}.png'));
    _playerList.add(Player.withColor(
        name: "🐹",
        score: 0,
        color: defaultColorList[3],
        textureName: 'assets/logo/texture-${Random().nextInt(8)}.png'));
    super.initState();
  }

  void _incrementCounter(Player player) {
    setState(() {
      player.score++;
    });
  }

  void sortPlayersWithAnimation() {
    final List<Player> sortedList = List.from(_playerList);

    // 排序逻辑
    sortedList.sort((a, b) {
      if (b.score != a.score) {
        return b.score.compareTo(a.score); // 按分数从大到小排序
      }
      return _playerList.indexOf(a).compareTo(_playerList.indexOf(b)); // 保持顺位不变
    });

    // 移除所有项
    for (int i = _playerList.length - 1; i >= 0; i--) {
      final Player removedPlayer = _playerList[i];
      _listKey.currentState?.removeItem(
          i,
          (context, animation) => SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: Offset(1, 0), // 从右侧滑入
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeInOut)),
                ),
                child: Container(
                  height: 150.h,
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ));
    }

    // 延迟插入排序后的项
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _playerList.clear();
        _playerList.addAll(sortedList);
      });

      for (int i = 0; i < sortedList.length; i++) {
        _listKey.currentState?.insertItem(i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      ///设置文字大小不随系统设置改变
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
          backgroundColor: const Color(0xfff9e0b2),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            CupertinoColors.link,
                          ),
                        ),
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
                        },
                        child: Icon(
                          Icons.restart_alt,
                          size: 35.sp,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            isShowingTimer
                                ? CupertinoColors.activeGreen
                                : CupertinoColors.inactiveGray,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isShowingTimer = !isShowingTimer;
                          });
                        },
                        child: Icon(
                          Icons.punch_clock_outlined,
                          size: 35.sp,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
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
                                              child: CupertinoPicker(
                                                itemExtent: 32.0,
                                                onSelectedItemChanged:
                                                    (int index) {
                                                  selectedMinutes = index;
                                                },
                                                children: List<Widget>.generate(
                                                    60, (int index) {
                                                  return Center(
                                                      child: Text('$index'));
                                                }),
                                              ),
                                            ),
                                            Text(":",
                                                style: TextStyle(
                                                    fontSize: 28.sp,
                                                    color: Colors.black)),
                                            Expanded(
                                              child: CupertinoPicker(
                                                itemExtent: 32.0,
                                                onSelectedItemChanged:
                                                    (int index) {
                                                  selectedSeconds = index * 5;
                                                },
                                                children: List<Widget>.generate(
                                                  12, // 每5秒一个间隔，总共12个选项（0到55秒）
                                                  (int index) {
                                                    return Center(
                                                      child:
                                                          Text('${index * 5}'),
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
                                                selectedMinutes * 60 +
                                                    selectedSeconds;
                                            isShowingCountdownTimer =
                                                !isShowingCountdownTimer;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        style: ButtonStyle(
                                          minimumSize: WidgetStateProperty.all(
                                              Size(100.w, 50.h)), // 设置按钮的最小尺寸
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  CupertinoColors.activeGreen),
                                        ),
                                        child: Text(
                                          'ok',
                                          style: TextStyle(
                                              color: Colors.white,
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
                          size: 35.sp,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            isShowingSubCounter1 && isShowingSubCounter2
                                ? CupertinoColors.activeBlue
                                : isShowingSubCounter1
                                    ? CupertinoColors.activeGreen
                                    : CupertinoColors.inactiveGray,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (isShowingSubCounter2) {
                              isShowingSubCounter1 = false;
                              isShowingSubCounter2 = false;
                            } else if (isShowingSubCounter1) {
                              isShowingSubCounter2 = true;
                            } else {
                              isShowingSubCounter1 = true;
                            }
                          });
                        },
                        child: Icon(
                          Icons.iso,
                          size: 35.sp,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            CupertinoColors.link,
                          ),
                        ),
                        onPressed: () {
                          sortPlayersWithAnimation();
                        },
                        child: Icon(
                          Icons.sort,
                          size: 35.sp,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            String inputName = '';
                            String? playerName =
                                await showModalBottomSheet<String>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: const Color(0xfff9e0b2),
                              // 设置背景色
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom, // 避免键盘遮挡
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 350.h,
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Text('添加玩家名称',
                                        //     style: CustomTextStyle.xiangjiao),
                                        SizedBox(height: 35.h),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff233c4c),
                                                  width: 8.w),
                                              color: Colors.white70),
                                          width: 350.w,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            onChanged: (value) {
                                              inputName = value;
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'Name',
                                                hintStyle: CustomTextStyle
                                                    .xiangjiao
                                                    .copyWith(
                                                  fontSize: 20.sp,
                                                )),
                                            style: CustomTextStyle.xiangjiao
                                                .copyWith(
                                                    fontSize: 20.sp,
                                                    fontWeight: null),
                                          ),
                                        ),
                                        SizedBox(height: 35.h),
                                        TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    CupertinoColors
                                                        .activeGreen),
                                          ),
                                          child: Text(
                                            'OK',
                                            style: CustomTextStyle.xiangjiao,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(inputName);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            if (playerName != null && playerName.isNotEmpty) {
                              setState(() {
                                if (_playerList.length <
                                    defaultColorList.length) {
                                  _playerList.add(Player.withColor(
                                      name: playerName,
                                      score: 0,
                                      color:
                                          defaultColorList[_playerList.length],
                                      textureName:
                                          'assets/logo/texture-${Random().nextInt(8)}.png'));
                                } else {
                                  _playerList.add(Player.withColor(
                                      name: playerName,
                                      score: 0,
                                      color: Color(0xFF000000 +
                                          Random().nextInt(0x00FFFFFF)),
                                      textureName:
                                          'assets/logo/texture-${Random().nextInt(8)}.png'));
                                }
                                _listKey.currentState?.insertItem(
                                    _playerList.length - 1); // 插入动画
                              });
                            }
                          },
                          icon: Icon(
                            Icons.add_reaction,
                            size: 50.sp,
                            color: Color(0xff233c4c),
                          ))
                    ],
                  ),
                ),
                if (isShowingTimer)
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87, width: 4.w),
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                            color: Colors.white),
                        margin: EdgeInsets.only(bottom: 1.h),
                        width: 250.w,
                        child: _timerWidget),
                  ),
                if (isShowingCountdownTimer)
                  Center(
                    child: Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(
                        //         color: Color(0xff233c4c), width: 5.w),
                        //     color: Color(0xff326171)),
                        margin: EdgeInsets.only(bottom: 1.h),
                        width: 250.w,
                        child: CountdownTimerWidget(key: countdownTimerKey, initialSecond: initialSecond)),
                  ),
                Expanded(
                  child: _playerList.length <= 4
                      ? Column(children: [
                          Expanded(
                            child: AnimatedList(
                              padding: EdgeInsets.only(top: 5.h),
                              key: _listKey,
                              initialItemCount: _playerList.length,
                              itemBuilder: (context, index, animation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(-1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: BasicCounterCard(
                                    key: ValueKey(_playerList[index]),
                                    // 添加唯一的 Key
                                    player: _playerList[index],
                                    isShowSubCounter1: isShowingSubCounter1,
                                    isShowSubCounter2: isShowingSubCounter2,
                                    isShowTimer: isShowingTimer||isShowingCountdownTimer,
                                    length: _playerList.length,
                                    callback: (player) {
                                      setState(() {
                                        _playerList.remove(player);
                                        _listKey.currentState?.removeItem(
                                            index,
                                            (context, animation) =>
                                                SlideTransition(
                                                  position: animation.drive(
                                                    Tween<Offset>(
                                                      begin: Offset(1, 0),
                                                      // 从右侧滑入
                                                      end: Offset.zero,
                                                    ).chain(CurveTween(
                                                        curve:
                                                            Curves.easeInOut)),
                                                  ),
                                                  child: Container(
                                                    height: 150.h,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white70,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                    ),
                                                  ),
                                                ));
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ])
                      : ScrollbarTheme(
                          data: ScrollbarThemeData(
                            // thumbColor: WidgetStateProperty.all(Color(0xff233c4c)),
                            thickness: WidgetStateProperty.all(25.w), // 滚动条宽度
                            radius: Radius.circular(8.r), // 滚动条圆角
                            thumbVisibility:
                                WidgetStateProperty.all(true), // 始终显示滚动条
                            interactive: true,
                          ),
                          child: CupertinoScrollbar(
                            child: AnimatedList(
                              controller: _scrollController,
                              key: _listKey,
                              initialItemCount: _playerList.length,
                              itemBuilder: (context, index, animation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(-1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 25.w),
                                    child: BasicCounterCard(
                                      key: ValueKey(_playerList[index]),
                                      player: _playerList[index],
                                      isShowSubCounter1: isShowingSubCounter1,
                                      isShowSubCounter2: isShowingSubCounter2,
                                      isShowTimer: isShowingTimer||isShowingCountdownTimer,
                                      length: _playerList.length,
                                      callback: (player) {
                                        setState(() {
                                          final int index =
                                              _playerList.indexOf(player);
                                          _playerList.removeAt(index);
                                          _listKey.currentState?.removeItem(
                                            index,
                                            (context, animation) =>
                                                SlideTransition(
                                              position: Tween<Offset>(
                                                begin: Offset.zero,
                                                end: const Offset(
                                                    1, 0), // 向右滑出动画
                                              ).animate(animation),
                                              child: BasicCounterCard(
                                                key: ValueKey(player),
                                                player: player,
                                                isShowSubCounter1:
                                                    isShowingSubCounter1,
                                                isShowSubCounter2:
                                                    isShowingSubCounter2,
                                                isShowTimer: isShowingTimer || isShowingCountdownTimer,
                                                length: _playerList.length,
                                                callback: (player) {},
                                              ),
                                            ),
                                            duration: const Duration(
                                                milliseconds: 300), // 动画时长
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            ),
          )),
    );
  }
}
