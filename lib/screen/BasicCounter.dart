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

  final GlobalKey<TimerWidgetState> timerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

    _timerWidget = TimerWidget(key: timerKey);
    _playerList.add(Player(name: "P1", score: 0));
    _playerList.add(Player(name: "P2", score: 0));
    // _playerList.add(Player(name: "Player3", score: 0));
    // _playerList.add(Player(name: "Player4", score: 0));
    super.initState();
  }

  void _incrementCounter(Player player) {
    setState(() {
      player.score++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffaaaaaa),
      body:
      MediaQuery.of(context).orientation == Orientation.portrait?
      //=====竖屏=====
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xff233c4c), width: 8.w),
                          color: Color(0xff326171)),
                      margin: EdgeInsets.only(bottom: 25.h, top: 25.h),
                      width: 250.w,
                      child: _timerWidget),
                ],
              ),
              Positioned(
                  left: 0,
                  child: IconButton(
                      onPressed: (){
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
                      ))),
              Positioned(
                  right: 0,
                  child: IconButton(
                      onPressed: () async {
                        String inputName = '';
                        String? playerName =
                            await showModalBottomSheet<String>(
                          context: context,
                          backgroundColor: const Color(0xfff9e0b2),
                          // 设置背景色
                          builder: (BuildContext context) {

                            return SizedBox(
                              width: double.infinity,
                              height: 350.h,
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
                                      style: CustomTextStyle
                                          .xiangjiao
                                          .copyWith(
                                              fontSize: 20.sp,
                                              fontWeight: null),
                                    ),
                                  ),
                                  SizedBox(height: 35.h),
                                  TextButton(
                                    child: Text(
                                      '确定',
                                      style:
                                          CustomTextStyle.xiangjiao,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(inputName);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                        if (playerName != null &&
                            playerName.isNotEmpty) {
                          setState(() {
                            _playerList.add(
                                Player(name: playerName, score: 0));
                          });
                        }
                      },
                      icon: Icon(
                        Icons.add_reaction,
                        size: 50.sp,
                        color: Color(0xff233c4c),
                      ))),
            ]),
            Expanded(
              child: Column(
                children: _playerList
                    .map((player) => Expanded(
                      child: BasicCounterCard(
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
                      onPressed: (){
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
                          backgroundColor: const Color(0xfff9e0b2),
                          // 设置背景色
                          builder: (BuildContext context) {

                            return SizedBox(
                              width: double.infinity,
                              height: 350.h,
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
                                      style: CustomTextStyle
                                          .xiangjiao
                                          .copyWith(
                                          fontSize: 20.sp,
                                          fontWeight: null),
                                    ),
                                  ),
                                  SizedBox(height: 35.h),
                                  TextButton(
                                    child: Text(
                                      '确定',
                                      style:
                                      CustomTextStyle.xiangjiao,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(inputName);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                        if (playerName != null &&
                            playerName.isNotEmpty) {
                          setState(() {
                            _playerList.add(
                                Player(name: playerName, score: 0));
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
      )
    );
  }
}
