import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/presentation/administrative_class/bloc/administrative_class_details_bloc.dart';
import 'package:fakeslink/app/presentation/administrative_class/bloc/administrative_class_details_event.dart';
import 'package:fakeslink/app/presentation/administrative_class/bloc/administrative_class_details_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdministrativeClassScreen extends StatefulWidget {
  const AdministrativeClassScreen({Key? key}) : super(key: key);

  @override
  _AdministrativeClassScreenState createState() =>
      _AdministrativeClassScreenState();
}

class _AdministrativeClassScreenState extends State<AdministrativeClassScreen> {
  late final AdministrativeClassDetailsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AdministrativeClassDetailsBloc()
      ..add(AdministrativeClassDetailsInitEvent());
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Lớp hành chính", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColor.red,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocConsumer<AdministrativeClassDetailsBloc,
            AdministrativeClassDetailsState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is AdministrativeClassDetailsErrorState)
              showMyAlertDialog(context, "Lỗi", state.message);
          },
          listenWhen: (pre, next) =>
              next is AdministrativeClassDetailsErrorState,
          buildWhen: (pre, next) =>
              !(next is AdministrativeClassDetailsErrorState),
          builder: (context, state) {
            if (state is AdministrativeClassDetailsSuccessState) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lớp: ${state.details.administrativeClassId}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Sĩ số: ${state.details.students.length}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Ngành: ${state.details.faculty}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Cố vấn học tập: ${state.details.lecturer.name}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Mã giảng viên: ${state.details.lecturer.lecturerId}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      alignment: Alignment.centerLeft,
                      child: Text("Sinh viên:"),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                        List.generate(state.details.students.length, (index) {
                      Student student = state.details.students[index];
                      return Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: (student.avatar == null
                                          ? AssetImage("assets/images/user.jpg")
                                          : NetworkImage(student.avatar!))
                                      as ImageProvider,
                                  radius: 24,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        student.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        "Mã sinh viên: ${student.studentId}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.red),
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.red),
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.message_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            )
                          ],
                        ),
                      );
                    })),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.black,
                strokeWidth: 5,
              ),
            );
          },
        ),
      ),
    );
  }
}
