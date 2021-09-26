import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/app/presentation/registerable_class_details/bloc/registerable_class_details_bloc.dart';
import 'package:fakeslink/app/presentation/registerable_class_details/bloc/registerable_class_details_event.dart';
import 'package:fakeslink/app/presentation/registerable_class_details/bloc/registerable_class_details_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterableClassDetailsScreen extends StatefulWidget {
  final int id;
  const RegisterableClassDetailsScreen({Key? key, required this.id})
      : super(key: key);

  @override
  _RegisterableClassDetailsScreenState createState() =>
      _RegisterableClassDetailsScreenState();
}

class _RegisterableClassDetailsScreenState
    extends State<RegisterableClassDetailsScreen> {
  late final RegisterableClassDetailsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance()..add(RegisterableClassDetailsInitEvent(widget.id));
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
        title: Text("Lớp tín chỉ", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColor.red,
      ),
      body: BlocConsumer<RegisterableClassDetailsBloc,
          RegisterableClassDetailsState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is RegisterableClassDetailsErrorState)
            showMyAlertDialog(context, "Lỗi", state.message);
        },
        listenWhen: (pre, next) =>
            (next is RegisterableClassDetailsErrorState) && pre != next,
        buildWhen: (pre, next) => !(next is RegisterableClassDetailsErrorState),
        builder: (context, state) {
          if (state is RegisterableClassDetailsLoadingState)
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.black,
                strokeWidth: 5,
              ),
            );
          final data = (state as RegisterableClassDetailsSuccessfulState)
              .registerableClass;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16,top: 16),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Môn học: ${data.subject.subjectName}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16,),
                      Text("Mã môn học: ${data.subject.subjectId}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16,),
                      Text("Mã lớp học: ${data.id}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              ..._lecturers(data),
              SliverToBoxAdapter(
                child: Container(
                  color: AppColor.background,
                  width: double.infinity,
                  height: 16,
                ),
              ),
              ..._students(data)
            ],
          );
        },
      ),
    );
  }

  List<Widget> _lecturers(RegisterableClass data) {
    return [
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          color: Colors.white,
          child: Text(
            "Danh sách giảng viên",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          data.lecturers.map((e) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: (e.avatar == null
                            ? AssetImage("assets/images/user.jpg")
                            : NetworkImage(e.avatar!)) as ImageProvider,
                        radius: 24,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Mã giảng viên: ${e.lecturerId}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.red),
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
                            shape: BoxShape.circle, color: AppColor.red),
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.message_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            );
          }).toList(),
        ),
      )
    ];
  }

  List<Widget> _students(RegisterableClass data) {
    return [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          color: Colors.white,
          child: Row(
            children: [
              Text(
                "Danh sách sinh viên",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text("Sỹ số: ${data.students.length}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          data.students.map((e) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: (e.avatar == null
                            ? AssetImage("assets/images/user.jpg")
                            : NetworkImage(e.avatar!)) as ImageProvider,
                        radius: 24,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Mã sinh viên: ${e.studentId}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.red),
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
                            shape: BoxShape.circle, color: AppColor.red),
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.message_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            );
          }).toList(),
        ),
      )
    ];
  }
}
