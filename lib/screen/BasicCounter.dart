import 'dart:math';

import 'package:board_bar/model/Player.dart';
import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:board_bar/widget/BasicCounterCard.dart';
import 'package:board_bar/widget/TimerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/BasicCounterCardLandscape.dart';

class BasicCounter extends StatefulWidget {
  @override
  _BasicCounterState createState() => _BasicCounterState();
}

class _BasicCounterState extends State<BasicCounter> {
  List<Player> _playerList = [];
  TimerWidget? _timerWidget;
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

  final GlobalKey<TimerWidgetState> timerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

    _timerWidget = TimerWidget(key: timerKey);
    _playerList.add(
        Player.withColor(name: "🐴", score: 0, color: defaultColorList[0]));
    _playerList.add(
        Player.withColor(name: "🐶", score: 0, color: defaultColorList[1]));
    _playerList.add(
        Player.withColor(name: "🐒", score: 0, color: defaultColorList[2]));
    _playerList.add(
        Player.withColor(name: "🐹", score: 0, color: defaultColorList[3]));
    super.initState();
  }

  void _incrementCounter(Player player) {
    setState(() {
      player.score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      ///设置文字大小不随系统设置改变
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
          backgroundColor: const Color(0xffaaaaaa),
          body: MediaQuery.of(context).orientation == Orientation.portrait
              ?
              //=====竖屏=====
              Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                timerKey.currentState?.resetTimer();
                                setState(() {
                                  for (var player in _playerList) {
                                    player.score = 0;
                                    player.scoreDetail = [];
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.restart_alt,
                                size: 50.sp,
                                color: Color(0xff233c4c),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff233c4c), width: 8.w),
                                  color: Color(0xff326171)),
                              margin: EdgeInsets.only(bottom: 10.h, top: 25.h),
                              width: 250.w,
                              child: _timerWidget),
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
                                            Text('添加玩家名称',
                                                style: CustomTextStyle.xiangjiao),
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
                                                    hintText: '请输入名称',
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
                                              child: Text(
                                                '确定',
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
                                          color: defaultColorList[
                                              _playerList.length]));
                                    } else {
                                      _playerList.add(
                                          Player(name: playerName, score: 0));
                                    }
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
                      Expanded(
                          child: _playerList.length <= 4
                              ? Column(
                                  children: List.generate(
                                    _playerList.length,
                                    (index) => Expanded(
                                      child: BasicCounterCard(
                                        player: _playerList[index],
                                        length: _playerList.length,
                                        initialColor:
                                            index < defaultColorList.length
                                                ? defaultColorList[index]
                                                : Color(0xFF000000 +
                                                    Random().nextInt(0x00FFFFFF)),
                                        callback: (player) {
                                          setState(() {
                                            _playerList.remove(player);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Scrollbar(
                                  thumbVisibility: true,
                                  thickness: 10.w, // 设置滚动条的厚度
                                  radius: Radius.circular(10.r), // 设置滚动条的圆角
      
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    // 给滚动条和内容添加间距
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: List.generate(
                                          _playerList.length,
                                          (index) => BasicCounterCard(
                                            player: _playerList[index],
                                            length: _playerList.length,
                                            initialColor: index <
                                                    defaultColorList.length
                                                ? defaultColorList[index]
                                                : Color(0xFF000000 +
                                                    Random().nextInt(0x00FFFFFF)),
                                            callback: (player) {
                                              setState(() {
                                                _playerList.remove(player);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                    ],
                  ),
                )
              :
      
              //横屏
              Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                timerKey.currentState?.resetTimer();
                                setState(() {
                                  for (var player in _playerList) {
                                    player.score = 0;
                                    player.scoreDetail = [];
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.restart_alt,
                                size: 35.sp,
                                color: Color(0xff233c4c),
                              )),
                          // Container(
                          //     decoration: BoxDecoration(
                          //         border: Border.all(
                          //             color: Color(0xff233c4c), width: 8.w),
                          //         color: Color(0xff326171)),
                          //     margin: EdgeInsets.only(bottom: 25.h, top: 25.h),
                          //     width: 50.w,
                          //     child: _timerWidget),
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
                                            Text('添加玩家名称',
                                                style: CustomTextStyle.xiangjiao),
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
                                                    hintText: '请输入名称',
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
                                              child: Text(
                                                '确定',
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
                                          color: defaultColorList[
                                              _playerList.length]));
                                    } else {
                                      _playerList.add(
                                          Player(name: playerName, score: 0));
                                    }
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.add_reaction,
                                size: 30.sp,
                                color: Color(0xff233c4c),
                              ))
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: _playerList
                              .map((player) => Expanded(
                                    child: BasicCounterCardLandscape(
                                        player: player,
                                        length: _playerList.length,
                                        callback: (player) {
                                          setState(() {
                                            _playerList.remove(player);
                                          });
                                        }),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
