class Semester {
  String semesterId;
  DateTime startAt;
  DateTime endAt;
  int weeks;

  Semester({required this.semesterId, required this.startAt, required this.endAt, required this.weeks});

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterId : json['semesterId'],
      startAt : DateTime.parse(json['startAt']),
      endAt : DateTime.parse(json['endAt']),
      weeks : json['weeks'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semesterId'] = this.semesterId;
    data['startAt'] = this.startAt;
    data['endAt'] = this.endAt;
    data['weeks'] = this.weeks;
    return data;
  }
}
