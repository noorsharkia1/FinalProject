class checkLoginModel {
  String? userID;
  String? firstName;
  String? email;
  String? gender;

  checkLoginModel({
    this.userID,
    this.firstName,
    this.email,
    this.gender,

  });


  factory checkLoginModel.fromJson(Map<String, dynamic> json) {
    return checkLoginModel(
      userID: json['userID'],
      firstName: json['FirstName'],
      email: json['Email'],
        gender: json['Gender'],

    );
  }
}

