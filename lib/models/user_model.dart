// read the user information to show in "me" menu
class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  // constructor
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orderCount,
  });

  // get the json from database
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel (
      id:json['id'],
      name:json['f_name'],
      email:json['email'],
      phone:json['phone'],
      orderCount:json['order_count'],

    );
  }
}