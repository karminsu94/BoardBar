import 'package:board_bar/screen/BasicCounter.dart';
import 'package:board_bar/screen/CustomCounter.dart';
import 'package:board_bar/widget/PixelButton.dart';
import 'package:board_bar/widget/PixelBorderPainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 892),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'BB',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
              useMaterial3: true,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9e0b2),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: PixelButton(title: '✍Basic Counter',width: 300.w, fontSize: 25.sp,onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BasicCounter(),
                ),
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child:   PixelButton (title: "Duel Counter",width: 300.w, fontSize: 25.sp,onTap: (){}),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child:   PixelButton (title: "♛Count Down",width: 300.w, fontSize: 25.sp,onTap: (){}),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child:   PixelButton (title: "Custom Counter",width: 300.w, fontSize: 25.sp,onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomCounter(),
                ),
              );
            }),
          ),
        ],
      )),
    );
  }
}
