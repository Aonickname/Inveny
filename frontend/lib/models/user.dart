class User {
  final int? userNo;
  final String loginId;
  final String password;

  User({
    this.userNo,
    required this.loginId,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userNo: json['userNo'],
      loginId: json['loginId'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNo': userNo,
      'loginId': loginId,
      'password': password,
    };
  }
}