import 'package:fakeslink/app/domain/entities/subject.dart';

class SubjectModel extends Subject {
  SubjectModel(
      {required subjectId,
        required subjectName,
        required tinchi,
        required gPACoefficient,
        required isCPA,
        required coefficient})
      : super(
    subjectId: subjectId,
    subjectName: subjectName,
    coefficient: coefficient,
    gPACoefficient: gPACoefficient,
    isCPA: isCPA,
    tinchi: tinchi
  );

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subjectId: json['subjectId'],
      subjectName: json['subjectName'],
      tinchi: json['tinchi'],
      gPACoefficient: json['GPA_Coefficient'],
      isCPA: json['isCPA'],
      coefficient: json['coefficient'].cast<int>(),
    );
  }
}
