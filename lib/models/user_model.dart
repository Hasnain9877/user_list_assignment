class UserModel {
  String name;
  int age;
  double marks;
  String gender;

  UserModel({
    required this.name,
    required this.age,
    required this.marks,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      age: int.tryParse(json['age'].toString()) ?? 0,
      marks: double.tryParse(json['marks'].toString()) ?? 0.0,
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age.toString(),
    'marks': marks.toString(),
    'gender': gender,
  };
}
