import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/CustomTextStyle.dart';

// 1. 定义一个 GlobalKey
final GlobalKey<TimerWidgetState> timerKey = GlobalKey<TimerWidgetState>();

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);


  @override
  TimerWidgetState createState() => TimerWidgetState();

}

class TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late Timer _colonTimer;
  int _seconds = 0;
  bool _isRunning = false;
  bool _showColon = true;

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });

      _colonTimer.cancel();

      setState(() {
        _isRunning = true;
        _showColon = true;
      });
    }
  }

  void _pauseTimer() {
    if (_isRunning) {
      _timer.cancel();

      _colonTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
        setState(() {
          _showColon = !_showColon;
        });
      });

      setState(() {
        _isRunning = false;
      });
    }
  }

  void resetTimer() {
    _seconds = 0;
    // if(!_isRunning){
    //   _startTimer();
    // }else{
    //   _pauseTimer();
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _colonTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _showColon = !_showColon;
      });
    });
    _startTimer();
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
      _colonTimer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _showColon
              ? Duration(seconds: _seconds).toString().split('.').first
              : Duration(seconds: _seconds)
                  .toString()
                  .split('.')
                  .first
                  .replaceAll(':', ' '),
          style: CustomTextStyle.pressStart2p.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 23.sp,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isRunning
                  ? Icons.pause_circle_outline_rounded
                  : Icons.play_circle_outline_rounded),
              iconSize: 30.sp,
              color: const Color(0xff000000),
              onPressed: () {
                if (_isRunning) {
                  _pauseTimer();
                } else {
                  _startTimer();
                }
              },
            ),
          ],
          // children: [
          //   GestureDetector(
          //     child: Text(_isRunning?"⏸️":"▶️",
          //         style: CustomTextStyle.pressStart2p.copyWith(
          //             fontWeight: FontWeight.w300,
          //             fontSize: 23.sp,
          //             color: const Color(0xff000000))),
          //     onTap: () {
          //       if (_isRunning) {
          //         _pauseTimer();
          //       } else {
          //         _startTimer();
          //       }
          //     },
          //   ),
          // ],
        ),
      ],
    );
  }
}
