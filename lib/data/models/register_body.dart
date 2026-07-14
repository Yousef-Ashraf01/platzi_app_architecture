class RegisterBody {
  final String name;
  final String email;
  final String password;
  final String avatar;

  RegisterBody({
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "email": email,
      "password": password,
      "avatar": avatar,
    };

    return data;
  }
}
