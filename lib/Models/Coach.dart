
import 'dart:convert';
class Client
{
  Client({
    this.firstName= "",
    this.lastName= "",
    this.email= "",
    this.password= "",
    this.gender= "",
    this.height="",
    this.weight="",
    this.age="",
});

  String firstName;
  String lastName;
  String email;
  String password;
  String gender;
  String height;
  String weight;
  String age;


  factory Client.fromJson(Map<String,dynamic> json)=> Client(
   firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["passsword"],
    gender: json["gender"],
    height: json["height"],
    weight: json["weight"],
    age: json["age"],

  );
Map<String, dynamic >toJson() =>{
  "firstNme" : firstName,
  "lastName": lastName,
  "email": email,
  "password": password,
  "gender": gender,
  "height": height,
  "weight": weight,
  "age": age,

};

}