import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photogram/home.dart';
import 'package:photogram/shared_pref.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";
  var emailController = TextEditingController();
  var pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      var dio = Dio();
      try {
        var response = await dio.post(
          "$baseUrl/login",
          data: {"email": emailController.text, "password": pwController.text},
        );
        SharedPref.pref?.setString("token", response.data["data"]["token"]);

        print(response.data["data"]["token"]);
        print("${SharedPref.pref?.getString("token")}");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        print("pw salah");
      }
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            // title: Icon(Icons.arrow_back_ios),
            leading: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SelectionArea(
                child: Column(
                  children: [
                    Text(
                      'Welcome back! Glad to see you again!',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 48,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "enter your email"),
                    ),
                    Container(
                      height: 12,
                    ),
                    TextFormField(
                      controller: pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "enter your password"),
                    ),
                    Container(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text('forgot password')],
                    ),
                    Container(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.black)),
                        onPressed: () async {
                          // print(emailController);
                          // print(pwController);
                          await login();
                        },
                        child: Text("Login"),
                      ),
                    ),
                    Container(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.grey,
                          width: 120,
                          height: 2,
                        ),
                        Text("Or Login With"),
                        Container(
                          color: Colors.grey,
                          width: 120,
                          height: 2,
                        )
                      ],
                    ),
                    Container(
                      height: 36,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 36,
                          // child: Image.network(
                          //     "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png"),
                        ),
                        Container(
                          height: 36,
                          // child: Image.network(
                          //     "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png"),
                        ),
                        Container(
                          height: 36,
                          // child: Image.network(
                          //     "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/625px-Apple_logo_black.svg.png"),
                        )
                      ],
                    ),
                    Container(
                      height: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don’t have an account?"),
                        Container(width: 12),
                        Text(
                          "Register Now",
                          style: TextStyle(color: Colors.cyan),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
