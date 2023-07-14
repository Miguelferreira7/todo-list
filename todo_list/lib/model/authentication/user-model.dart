class UserModel {
  final String email;
  final String password;
  final bool  returnSecureToken = true;

  UserModel({required this.email, required this.password});

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  bool emailCorrect() {
    if (email.contains("@") || email.contains(".com")) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'returnSecureToken': returnSecureToken,
    };
  }
}
