import 'package:flutter/material.dart';
import 'package:photogram/home.dart';
import 'package:photogram/logg.dart';
import 'package:photogram/shared_pref.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      var token = SharedPref.pref?.getString("token");

      if (token == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("splash"),
      ),
    );
  }
}
