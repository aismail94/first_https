class Profile {
  int id;

  String name;
  String email;
  String avatar;
  String role;

  Profile({
    required this.name,
    required this.email,
    required this.avatar,
    required this.role,
    required this.id,
  });

  factory Profile.fromJson(Map json) {
    return Profile(
      name: json['name'],
      avatar: json['avatar'],
      email: json['email'],
      role: json['role'],
      id: json['id'],
    );
  }
}
