import 'package:celebrate/view/Home.dart';
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
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'celebrate',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,

            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                  color: Colors.black),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: HomeView(),
        );
      },
    );;
  }
}

