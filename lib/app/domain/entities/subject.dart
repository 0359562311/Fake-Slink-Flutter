class Subject {
  String subjectId;
  String subjectName;
  int tinchi;
  int gPACoefficient;
  bool isCPA;
  List<int> coefficient;

  Subject(
      {required this.subjectId,
        required this.subjectName,
        required this.tinchi,
        required this.gPACoefficient,
        required this.isCPA,
        required this.coefficient});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectId'] = this.subjectId;
    data['subjectName'] = this.subjectName;
    data['tinchi'] = this.tinchi;
    data['GPA_Coefficient'] = this.gPACoefficient;
    data['isCPA'] = this.isCPA;
    data['coefficient'] = this.coefficient;
    return data;
  }
}