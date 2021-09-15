import 'package:fakeslink/app/presentation/results/widget/first_tab/result_chart.dart';
import 'package:fakeslink/app/presentation/results/widget/first_tab/result_table_and_detail.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';

class ResultFirstTab extends StatelessWidget {
  const ResultFirstTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ResultChart(),
              ResultTableAndDetail()
            ],
          ),
        ),
      ),
    );
  }
}