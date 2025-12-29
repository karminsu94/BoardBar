import 'package:board_bar/model/Player.dart';
import 'package:board_bar/model/Script.dart';
import 'package:board_bar/model/ScriptRecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/CustomTextStyle.dart';
import '../widget/CustomCounterPlayerCard.dart';

class CustomCounter extends StatefulWidget {
  const CustomCounter({Key? key}) : super(key: key);

  @override
  _CustomCounterState createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  List<Script> _scriptList = [];
  List<ScriptRecord> _scriptRecordList = [];

  String _currentScriptName = '';
  @override
  void initState() {
    // TODO: implement initState
    _scriptList.add(Script(name: "Harmony", fieldList: ["Animal","Forest","Mountain","Continent","River","Building"]));
    _scriptRecordList.add(ScriptRecord.inital(playerName: 'p1'));
    _scriptRecordList.add(ScriptRecord.inital(playerName: 'p2'));
    _scriptRecordList.add(ScriptRecord.inital(playerName: 'p3'));
    _scriptRecordList.add(ScriptRecord.inital(playerName: 'p4'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      ///设置文字大小不随系统设置改变
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
          body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("script"),
                      content: SizedBox(
                        height: 300.h,
                        child: SingleChildScrollView (
                          child: Column(
                            children: _scriptList.map((script) {
                              return ListTile(
                                title: Text(script.name),
                                onTap: () {
                                  setState(() {
                                    _currentScriptName = script.name;
                                  });
                                  Navigator.of(context).pop(); // 关闭对话框
                                },
                              );
                            }).toList(),
                          ),

                        ),
                      ),
                    ),
                  );
                },
                child: Text(_currentScriptName.isEmpty ? "script" : _currentScriptName),
              ),
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
                        _scriptRecordList.add(
                            ScriptRecord(scriptId: '1', matchId: '1', playerName: playerName, scoreList: [], scoreDetail: []));
                      });
                    }
                  },
                  icon: Icon(
                    Icons.add_reaction,
                    size: 50.sp,
                    color: Color(0xff233c4c),
                  )),
              IconButton(onPressed: (){

              }, icon: Icon(
                Icons.done,
                size: 50.sp,
                color: Color(0xff233c4c),
              ))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _scriptRecordList.length,
              itemBuilder: (context, index) {
                final record = _scriptRecordList[index];
                CustomCounterPlayerCard(
                  scriptRecord: record,
                  callback: (record) {
                    setState(() {
                      _scriptRecordList.remove(record);
                    });
                  },
                );
              },
            ),
          ),

        ],
      )),
    );
  }
}
