import 'package:fakeslink/app/domain/entities/gpa.dart';

class GPAModel extends GPA {
  GPAModel({
    required num gpa,
    required num accumulated
  }) : super(
    gpa: gpa,
    accummulated: accumulated
  );

  factory GPAModel.fromJson(Map<String,dynamic> json) 
    => GPAModel(gpa: json['GPA'], accumulated: json['accumulated']);

}