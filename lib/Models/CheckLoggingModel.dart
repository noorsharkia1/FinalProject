class checkLoginModel {
  String? result;
  String? userTypeID;
  String? fullName;




  checkLoginModel({
    this.result,
    this.userTypeID,
    this.fullName,


  });


  factory checkLoginModel.fromJson(Map<String, dynamic> json) {
    return checkLoginModel(
      result: json['result'],
      userTypeID: json['userTypeID'],
      fullName: json['fullName'],


    );
  }
}

