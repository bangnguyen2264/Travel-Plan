class PlanItem {
  final String id;
  final int stt;
  final String timeStart;
  final String timeClose;
  final String locationNote;
  final String locationId;
  final String locationName;
  final int numberDay;

  PlanItem({
    required this.id,
    required this.stt,
    required this.timeStart,
    required this.timeClose,
    required this.locationNote,
    required this.locationId,
    required this.locationName,
    required this.numberDay,
  });

  factory PlanItem.fromJson(Map<String, dynamic> json) {
    return PlanItem(
      id: json['id'],
      stt: json['stt'],
      timeStart: json['timeStart'] ?? '',
      timeClose: json['timeClose'] ?? '',
      locationNote: json['locationNote'] ?? '',
      locationId: json['locationId'],
      locationName: json['locationName'] ?? '',
      numberDay: json['numberDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stt': stt,
      'timeStart': timeStart,
      'timeClose': timeClose,
      'locationNote': locationNote,
      'locationId': locationId,
      'locationName': locationName,
      'numberDay': numberDay,
    };
  }
}
