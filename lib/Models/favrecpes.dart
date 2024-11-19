

class User
{
  User({

  this.highProtien=true,
  this.lowCarb= true,
  this.lowFat= true,
  this.vegetarian= true,
  this.vegan= true,
    this. pescatarian=true,

});
   bool highProtien;
  bool lowCarb;
  bool lowFat;
  bool vegetarian;
  bool vegan;
  bool pescatarian;

  factory User.fromJson(Map<String,dynamic> json)=> User(
   highProtien: json["highProtien"],
    lowCarb: json["lowCarb"],
    lowFat:json["lowFat"],
    vegetarian: json["vegetarian"],
    vegan: json["vegan"],
      pescatarian: json["pescatarian"],
  );
Map<String, dynamic >toJson() =>{
  "highProtien" : highProtien,
  "lowCarb": lowCarb,
  "lowFat": lowFat,
  "vegetarian": vegetarian,
  "vegan": vegan,
  "pescatarian": pescatarian,

};

}