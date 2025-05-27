class User
{
  User({
  this.userID= "",
  this.FirstName= "",
  this.LastName= "",
  this.Email= "",
  this.Height= "",
    this.Weight= "",
  });

  String userID;
  String FirstName;
  String LastName;
  String Email;
  String Height;
  String Weight;

  factory User.fromJson(Map<String,dynamic> json)=> User(
    userID: json["userID"],
    FirstName: json["FirstName"],
    LastName:json["LastName"],
    Email: json["Email"],
    Height: json["Height"],
    Weight: json["Weight"],
  );

  // {"userID":"3","FirstName":"noor","LastName":"sharkia","Email":"3@3","Height":166,"Weight":50,"Gender":""}


Map<String, dynamic >toJson() =>{
  "id" : userID,
  "name": FirstName,
  "phone": LastName,
  "Email": Email,
  "Height": Height,
  "Weight": Weight,

};

}