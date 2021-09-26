import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/presentation/registerable_class/bloc/list_registerable_class_bloc.dart';
import 'package:fakeslink/app/presentation/registerable_class/bloc/list_registerable_class_event.dart';
import 'package:fakeslink/app/presentation/registerable_class/bloc/list_registerable_class_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ListRegisterableClassScreen extends StatefulWidget {
  const ListRegisterableClassScreen({ Key? key }) : super(key: key);

  @override
  _ListRegisterableClassScreenState createState() => _ListRegisterableClassScreenState();
}

class _ListRegisterableClassScreenState extends State<ListRegisterableClassScreen> {

  List<String> semesters = [];
  late String current;
  late final ListRegisterableClassBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance()..add(ListRegisterableClassInitEvent());
    current = GetIt.instance<Semester>().semesterId;
    if (GetIt.instance.isRegistered<Student>()) {
      final user = GetIt.instance<Student>();
      String to = current;
      for (int i = int.parse(user.studentId.substring(1, 3));
          i <= int.parse(to.substring(2, 4));
          i++) {
        for (int j = 1; j <= 3; j++) {
          semesters.add("20$i$j");
          if (i == int.parse(to.substring(2, 4)) &&
              j == int.parse(to.substring(4))) break;
        }
      }
      semesters = semesters.reversed.toList();
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông báo",
          style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: BlocConsumer<ListRegisterableClassBloc, ListRegisterableClassState>(
          bloc: _bloc,
          listener: (context, state) {
            if(state is ListRegisterableClassErrorState)
              showMyAlertDialog(context, "Lỗi", state.message);
          },
          listenWhen: (pre, next) => (next is ListRegisterableClassErrorState) && next != pre,
          builder:(context, state) {
            if(state is ListRegisterableClassLoadingState)
              return Center(
                child: CircularProgressIndicator(color: AppColor.black, strokeWidth: 5,),
              );
            return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(child: _dropdownButton(), alignment: Alignment.center,),
                _listRegisterableClass((state as ListRegisterableClassSuccessfulState).registers)
              ],
            ),
          );
          },
        ),
      ),
    );
  }

  Widget _listRegisterableClass(List<Register> registers) {
    return Column(
      children: registers.where((element) => element.registerableClass.semester == current).map((e){
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 0.5, color: AppColor.black)
          ),
          child: Row(
            children: [
              Icon(Icons.class__rounded, color: AppColor.red,),
              SizedBox(width: 32,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lớp: ${e.registerableClass.subject.subjectName}",
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 12,),
                    Text("Mã lớp: ${e.registerableClass.subject.subjectId}",
                      style: TextStyle(color: AppColor.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }).toList()
    );
  }

  Widget _dropdownButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.3,
                  color: Colors.black87,
                  offset: Offset(0, 0.3))
            ],
            color: Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            items: semesters
                .map((str) => DropdownMenuItem(
                      value: str,
                      child: Text(
                        "Học kỳ ${str.substring(4)} - năm ${str.substring(0, 4)}",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      ),
                    ))
                .toList(),
            hint: Text(
                "Học kỳ ${current.substring(4)} - năm ${current.substring(0, 4)}"),
            onChanged: (val) {
              setState(() {
                current = val.toString();
              });
            },
          ),
        ));
  }
}