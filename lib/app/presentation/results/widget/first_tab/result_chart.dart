import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_bloc.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultChart extends StatefulWidget {
  const ResultChart({Key? key}) : super(key: key);

  @override
  _ResultChartState createState() => _ResultChartState();
}

class _ResultChartState extends State<ResultChart> with AutomaticKeepAliveClientMixin<ResultChart> {

  final ZoomPanBehavior _behavior = ZoomPanBehavior(
      maximumZoomLevel: 2,
      zoomMode: ZoomMode.x
    );

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<ResultBloc>(context);
    final data = _filter(_bloc);
    print("TanKiem: rebuild chart");
    super.build(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text("Điểm tích luỹ qua từng kỳ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
          ),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            zoomPanBehavior: _behavior,
            series: <ChartSeries>[
              StackedLineSeries(
                  dataSource: data,
                  xValueMapper: (value, _) => value.semester,
                  yValueMapper: (value, _) {
                    if (value.accumulated > 0) return double.parse((value.total/value.accumulated).toStringAsFixed(2));
                    return 0;
                  },
                  color: AppColor.red,
                  xAxisName: "Học kì",
                  yAxisName: "GPA",
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      showCumulativeValues: true,
                      useSeriesColor: true),
                  markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle)
                  )
            ],
          ),
        ),
      ],
    );
  }

  double _getTongKetChu(double d) {
      if(d < 4) return 0;
      else if (d < 5) return 1;
      else if (d < 5.5) return 1.5;
      else if (d < 6.5) return 2;
      else if (d < 7) return 2.5;
      else if (d < 8) return 3;
      else if (d < 8.5) return 3.5;
      else if (d < 9) return 3.7;
      else return 4;
  }

  List<_ChartData> _filter(ResultBloc _bloc) {
    final data = <_ChartData>[];
    double total = 0;
    int accumulated = 0;
    _bloc.register.forEach((r) { 
      if(r.registerableClass.semester.compareTo(GetIt.instance<Semester>().semesterId) < 0) {
        if(data.isEmpty || data.last.semester != r.registerableClass.semester) {
          data.add(_ChartData(r.registerableClass.semester, ));
        }
        if(r.registerableClass.subject.isCPA && r.total != null) {
          data.last.total = total += _getTongKetChu(r.total!) * r.registerableClass.subject.gPACoefficient;
          data.last.accumulated = accumulated += r.registerableClass.subject.gPACoefficient;
        }
      }
    });
    return data;
  }

  @override
  bool get wantKeepAlive => true;
}

class _ChartData {
  final String semester;
  double total = 0;
  int accumulated = 0;

  _ChartData(this.semester);
}
