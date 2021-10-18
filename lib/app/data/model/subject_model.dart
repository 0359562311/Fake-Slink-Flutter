import 'package:fakeslink/app/domain/entities/subject.dart';
import 'package:hive/hive.dart';

part 'subject_model.g.dart';

@HiveType(typeId: 3)
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
            tinchi: tinchi);

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
