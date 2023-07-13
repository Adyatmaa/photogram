

import 'package:photogram/user.dart';

class Post {
  final String title;
  final String content;
  final String picture;
  final User user;

  Post({
    required this.title,
    required this.content,
    required this.picture,
    required this.user,
  });
  factory Post.fromJason(Map<String, dynamic> json) {
    return Post(
        title: json['title'],
        content: json['content'],
        picture: json['picture'],
        user: User.fromJason(json['user'])
        );
  }
}
