class SignUpData {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  SignUpData({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      };

  static SignUpData fromJson(Map<String, dynamic> json) => SignUpData(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
      );
}
