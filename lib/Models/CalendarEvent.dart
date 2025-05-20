
class Coach
{
  Coach({
    this.coachID= 0,
    this.fullName= "",
    this.age= 0,
});

  int coachID;
  String fullName;
  int age;


  factory Coach.fromJson(Map<String,dynamic> json)=> Coach(
    coachID: json["coachID"],
    fullName: json["fullName"],
    age: json["age"],
  );


Map<String, dynamic >toJson() =>{
  "coachID" : coachID,
  "fullName": fullName,
  "age": age,
};

}


