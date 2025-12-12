import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleCalculator extends StatefulWidget {
  final int score;
  final List<String> scoreDetail;
  final Function(int, List<String>) callback;

  const SimpleCalculator(
      {super.key,
      required this.score,
      required this.scoreDetail,
      required this.callback});

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  // 当前输入的计算算式
  String _displayProcess = "";

  // 历史记录
  List<String> _calculationHistory = [];

  // 当前结果
  late int _currentResult;

  @override
  void initState() {
    super.initState();
    _calculationHistory = widget.scoreDetail;
    _currentResult = widget.score;
    _displayProcess = widget.score.toString();
  }

  void _onNumberPressed(int number) {
    setState(() {
      if (_displayProcess == "0") {
        _displayProcess = "$number";
      } else {
        _displayProcess += "$number";
      }
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      if (operation == "+" ||
          operation == "-" ||
          operation == "÷" ||
          operation == "×") {
        if (_displayProcess.isNotEmpty &&
            "+-×÷".contains(_displayProcess[_displayProcess.length - 1])) {
          _displayProcess =
              _displayProcess.substring(0, _displayProcess.length - 1) +
                  operation;
        } else {
          _displayProcess += operation;
        }
      } else if (operation == "=") {
        // 计算结果
        List<String> tokens = [];
        String currentOperation = "+";

        // 将历史记录// 使用正则表达式将_crurrentProcess转化为操作数和操作符的列表
        tokens = RegExp(r'(\d+|[+\-×÷])')
            .allMatches(_displayProcess)
            .map((e) => e.group(0)!)
            .toList();

        // 使用栈处理先乘除后加减
        List<int> stack = [];
        for (int i = 0; i < tokens.length; i++) {
          String token = tokens[i];
          if (token == "+" || token == "-") {
            currentOperation = token;
          } else if (token == "×" || token == "÷") {
            int prev = stack.removeLast();
            int value = int.parse(tokens[++i]);
            if (token == "×") {
              stack.add(prev * value);
            } else if (token == "÷") {
              stack.add(prev ~/ value); // 整数除法
            }
          } else {
            int value = int.parse(token);
            if (currentOperation == "+") {
              stack.add(value);
            } else if (currentOperation == "-") {
              stack.add(-value);
            }
          }
        }

        // 计算最终结果
        _currentResult = stack.fold(0, (sum, element) => sum + element);
        // 本次加数
        int addingParam = 0;
        if (_calculationHistory.isEmpty) {
          addingParam = _currentResult;
        } else if (stack.length == 1) {
          addingParam = stack[0];
          _currentResult += addingParam;
        } else if (tokens[0] == '-') {
          addingParam = _currentResult + int.parse(tokens[1]);
        } else {
          addingParam = _currentResult - int.parse(tokens[0]);
        }

        setState(() {
          // 保存过程记录
          if (addingParam >= 0) {
            _calculationHistory.add("+$addingParam");
          } else {
            _calculationHistory.add("$addingParam");
          }
          widget.callback(_currentResult, widget.scoreDetail);
          _displayProcess = "$_currentResult";

          widget.callback(_currentResult, _calculationHistory);
        });
      } else if (operation == "C") {
        setState(() {
          _displayProcess = "0";
          _currentResult = 0;
          _calculationHistory.clear();
          widget.callback(_currentResult, _calculationHistory);
        });
      } else if (operation == "↩") {
        if (_calculationHistory.isNotEmpty) {
          setState(() {
            _currentResult =
                _currentResult - int.parse(_calculationHistory.last);
            _displayProcess = _currentResult.toString();
            _calculationHistory.removeLast();
            widget.callback(_currentResult, _calculationHistory);
          });
        }
      } else if (operation == "AC") {
        if (_displayProcess != _currentResult.toString()) {
          setState(() {
            if (_displayProcess.length == 1 ||
                (_displayProcess.length == 1 &&
                    _displayProcess.contains("-"))) {
              _displayProcess = "0";
            } else {
              _displayProcess =
                  _displayProcess.substring(0, _displayProcess.length - 1);
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xff233c4c),
                width: 8.w,
              ),
              color: const Color(0xfff5ddaf),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.scoreDetail.length > 5
                        ? 5
                        : widget.scoreDetail.length, // 固定最多显示5个
                    itemBuilder: (context, index) {
                      // 如果列表长度大于5，显示最后的5个
                      final displayIndex = widget.scoreDetail.length > 5
                          ? widget.scoreDetail.length - 5 + index
                          : index;
                      return Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        alignment: Alignment.topRight,
                        child: Text(widget.scoreDetail[displayIndex],
                            style: CustomTextStyle.pressStart2p.copyWith(
                                fontSize: 12.sp, color: Colors.black87)),
                      );
                    },
                  ),
                ),
                Text(
                  _displayProcess,
                  style: CustomTextStyle.pressStart2p.copyWith(
                      fontSize: 30.sp, color: Colors.black87),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xff233c4c),
                  width: 8.w,
                ),
                left: BorderSide(
                  color: const Color(0xff233c4c),
                  width: 8.w,
                ),
                right: BorderSide(
                  color: const Color(0xff233c4c),
                  width: 8.w,
                ),
              ),
              color: const Color(0xff233c4c),
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                {
                  switch (index) {
                    case 0:
                      return _buildButton("C", () => _onOperationPressed("C"));
                    case 1:
                      return _buildButton("↩", () => _onOperationPressed("↩"));
                    case 2:
                      return _buildButton(
                          "AC", () => _onOperationPressed("AC"));
                    case 3:
                      return _buildButton("÷", () => _onOperationPressed("÷"));
                    case 4:
                      return _buildButton("7", () => _onNumberPressed(7));
                    case 5:
                      return _buildButton("8", () => _onNumberPressed(8));
                    case 6:
                      return _buildButton("9", () => _onNumberPressed(9));
                    case 7:
                      return _buildButton("×", () => _onOperationPressed("×"));
                    case 8:
                      return _buildButton("4", () => _onNumberPressed(4));
                    case 9:
                      return _buildButton("5", () => _onNumberPressed(5));
                    case 10:
                      return _buildButton("6", () => _onNumberPressed(6));
                    case 11:
                      return _buildButton("-", () => _onOperationPressed("-"));
                    case 12:
                      return _buildButton("1", () => _onNumberPressed(1));
                    case 13:
                      return _buildButton("2", () => _onNumberPressed(2));
                    case 14:
                      return _buildButton("3", () => _onNumberPressed(3));
                    case 15:
                      return _buildButton("+", () => _onOperationPressed("+"));
                    case 16:
                      return SizedBox.shrink();
                    case 17:
                      return _buildButton("0", () => _onNumberPressed(0));
                    case 18:
                      return SizedBox.shrink();
                    case 19:
                      return _buildButton("=", () => _onOperationPressed("="));
                    default:
                      return SizedBox.shrink();
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffb44f33),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        onPressed: onPressed,
        child:
        label=="AC"?
            Icon(Icons.backspace,
                size: 28.sp,
                color: const Color(0xfff5ddaf))
            :
        label=="↩"?
            Icon(Icons.undo,
                size: 28.sp,
                color: const Color(0xfff5ddaf))
            :
        Text(label,
            style: CustomTextStyle.pressStart2p.copyWith(
                letterSpacing: -8.0.w,
                fontSize: 28.sp,
                color: const Color(0xfff5ddaf))),
      ),
    );
  }

  Widget _buildLongButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            decoration: BoxDecoration(
                color: const Color(0xffb44f33),
                borderRadius: BorderRadius.circular(10)),
            child: Text(label,
                style: CustomTextStyle.pressStart2p.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 25.sp,
                    color: const Color(0xfff5ddaf)))),
      ),
    );
  }
}
