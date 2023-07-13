import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photogram/logg.dart';
import 'package:photogram/post.dart';
import 'package:photogram/shared_pref.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  var baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";
  Future<List<Post>> getData() async {
    var dio = Dio();
    var token = SharedPref.pref?.getString("token");
    var response = await dio.get("$baseUrl/post",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    print(response);
    // print(token);

    List<Post> listPost =
        (response.data['data'] as List).map((e) => Post.fromJason(e)).toList();
    print("a");
    // print(listPost);
    return listPost;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onLogout() async {
      var dio = Dio();
      var token = SharedPref.pref?.getString("token");
      try {
        var response = await dio.post("$baseUrl/logout",
            options: Options(headers: {"Authorization": "Bearer $token"}));
        SharedPref.pref?.remove("token");
        print(response);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } catch (e) {
        print("mohon maaf kesalahan email dan  password");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Photogram",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        // elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              onLogout();
            },
            icon: Icon(Icons.logout),
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       child: ElevatedButton(
            //           onPressed: () {
            //             onLogout();
            //           },
            //           child: Text("logout")),
            //     ),
            //   ],
            // ),
            // Container(
            //   height: 24,
            //   child: Text("Photogram"),
            // ),
            SizedBox(
              height: 24,
            ),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text("Ini tampilan error");
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (ctx, i) {
                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "User : ${snapshot.data?[i].user.nama}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "Title : ${snapshot.data?[i].title}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      // SizedBox(
                                      //   width: 8,
                                      // ),
                                      Image.network(
                                        "https://b517-103-17-77-3.ngrok-free.app/storage/images/${snapshot.data?[i].picture}",
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "Content : ${snapshot.data?[i].content}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    color: Colors.black,
                                    width: MediaQuery.of(context).size.width,
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
