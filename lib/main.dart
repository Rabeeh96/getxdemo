import 'package:demo_getx/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:demo_getx/views/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:demo_getx/views/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      themeMode: ThemeMode.system,
    );
  }
}
