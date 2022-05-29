///{id: 1, userId: 200120003, name: 홍길동, userType: STUDENT, email: qweqwe@ajou.ac.kr, password: $2b$05$JY46LM8nrScvYoC7tzKPc.Qgj980BjoB7dwOpB6kdTKA4V2cjwdN6, phone: null, createdAt: 2022-05-22T07:17:15.469Z}}
enum UserType { student, professor }

class User {
  int id;
  int userId;
  String name;
  UserType userType;
  String email;
  String? phone;
  String? path;

  User(this.id, this.userId, this.name, this.userType, this.email, this.phone,
      {this.path});

  @override
  String toString() {
    return 'User{id: $id, userId: $userId, name: $name, userType: $userType, email: $email, phone: $phone}';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    UserType? userType;
    if (json['userType'] == 'STUDENT') {
      userType = UserType.student;
    } else {
      userType = UserType.professor;
    }
    return User(
      json['id'],
      json['userId'],
      json['name'],
      userType,
      json['email'],
      json['phone'],
      path: json['path'],
    );
  }
}
