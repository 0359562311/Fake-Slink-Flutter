import 'package:hive/hive.dart';

part 'subject.g.dart';

@HiveType(typeId: 3)
class Subject extends HiveObject {
  @HiveField(0)
  String subjectId;
  @HiveField(1)
  String subjectName;
  @HiveField(2)
  int tinchi;
  @HiveField(3)
  int gPACoefficient;
  @HiveField(4)
  bool isCPA;
  @HiveField(5)
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