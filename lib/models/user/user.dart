class User {
  int id;
  String name;
  String email;
  String avatarUrl;
  String role;

  User({this.avatarUrl, this.id, this.name, this.email, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      avatarUrl: json["avatar_url"] ?? json["avatarUrl"],
      role: json["role"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "email": this.email,
        "avatarUrl": this.avatarUrl,
        "role": this.role,
      };
}
