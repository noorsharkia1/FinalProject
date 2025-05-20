
class CalendarEvent
{
  CalendarEvent({
      this.coachID= 0,
      this.startHour= "",
      this.endHour= "",
  });

  int coachID;
  String startHour;
  String endHour;


  factory CalendarEvent.fromJson(Map<String,dynamic> json)=> CalendarEvent(
    coachID: json["coachID"],
    startHour: json["startHour"],
    endHour: json["endHour"],
  );


  Map<String, dynamic >toJson() =>{
    "coachID" : coachID,
    "startHour": startHour,
    "endHour": endHour,
  };

}

