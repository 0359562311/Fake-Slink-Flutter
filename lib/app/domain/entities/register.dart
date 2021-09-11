import 'registerable_class.dart';

class Register {
  int id;
  RegisterableClass registerableClass;
  List<double> points;
  double total;
  int student;

  Register(
      {required this.id,
      required this.registerableClass,
      required this.points,
      required this.total,
      required this.student});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registerableClass'] = this.registerableClass.toJson();
    data['points'] = this.points;
    data['total'] = this.total;
    data['student'] = this.student;
    return data;
  }
}
