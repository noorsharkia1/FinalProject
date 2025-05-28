class CoachEvent {
  final String startHour;
  final String userID;
  final String coachID;

  CoachEvent({
    required this.startHour,
    required this.userID,
    required this.coachID,
  });

  factory CoachEvent.fromJson(Map<String, dynamic> json) {
    return CoachEvent(
      startHour: json['startHour'] ?? '',
      userID: json['userID'] ?? '',
      coachID: json['coachID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startHour': startHour,
      'userID': userID,
      'coachID': coachID,
    };
  }
}
