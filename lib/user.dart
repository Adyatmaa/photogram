class User {
  final String nama;
  final String email;

  User({
    required this.nama,
    required this.email,
  });
  factory User.fromJason(Map<String, dynamic> json) {
    return User(nama: json['name'], email: json['email']);
  }
}
