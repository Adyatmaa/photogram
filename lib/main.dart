import 'package:flutter/material.dart';
import 'package:photogram/shared_pref.dart';
import 'package:photogram/splash.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp (const MyWidget());
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}