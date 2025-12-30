import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/CustomTextStyle.dart';

class CountdownTimerWidget extends StatefulWidget {
  int initialSecond;

  CountdownTimerWidget({super.key, required this.initialSecond});

  @override
  CountdownTimerWidgetState createState() => CountdownTimerWidgetState();
}

class CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer _timer;
  late Timer _colonTimer;

  late int _remainingSeconds; // 初始倒计时时间（单位：秒）
  bool _isRunning = false;
  bool _showColon = true;
  bool _isTimeUp = false; // 是否倒计时结束
  double _scale = 1.0; // 缩放比例
  Color _backgroundColor = Colors.white;

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _timer.cancel();
            _isRunning = false;
            _onTimeUp(); // 倒计时结束时触发
          }
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

  void _onTimeUp() {
    setState(() {
      _isTimeUp = true;
    });
    // 启动背景颜色动画
    _toggleBackgroundColor();
  }

  void resetTimer() {
    setState(() {
      _remainingSeconds = widget.initialSecond; // 重置为初始倒计时时间
      _isTimeUp = false;
      // _backgroundColor = Colors.white; // 恢复默认背景颜色
    });
    _startTimer();
  }

  void _toggleBackgroundColor() {
    if (_isTimeUp) {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _backgroundColor =
              _backgroundColor == Colors.white ? Colors.red : Colors.white;
        });
        _toggleBackgroundColor(); // 递归调用实现循环动画
      });
    }else{
      setState(() {
        _backgroundColor = Colors.white; // 恢复默认背景颜色
      });
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;

    return minutes == 0
        ? '${secs.toString().padLeft(2, '0')}'
        : '${minutes.toString()}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSecond;
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
    return AnimatedContainer(
      width: 135.w,
      height: 60.h,
      duration: Duration(milliseconds: 500), // 动画持续时间
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 4.w),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        color: _backgroundColor, // 动态背景颜色
      ),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _scale = 0.9; // 缩小
          });
        },
        onTapUp: (_) {
          setState(() {
            _scale = 1.0; // 恢复
            resetTimer(); // 重置倒计时
          });
        },
        onTapCancel: () {
          setState(() {
            _scale = 1.0; // 恢复
          });
        },
        child: AnimatedScale(
          scale: _scale,
          duration: Duration(milliseconds: 100),
          child: Center(
            child: Text(
              _showColon
                  ? _formatTime(_remainingSeconds)
                  : _formatTime(_remainingSeconds).replaceAll(':', ' '),
              style: CustomTextStyle.pressStart2p.copyWith(
                fontSize: 25.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
