import 'dart:io';

import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:fakeslink/app/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:fakeslink/app/presentation/edit_profile/bloc/edit_profile_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/custom_dialog.dart';
import 'package:fakeslink/core/custom_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final InputDecoration _defaultInputDecoration;
  final _formKey = GlobalKey<FormState>();
  late final EditProfileBloc _bloc;
  late final TextEditingController _phoneNumberController;
  @override
  void initState() {
    super.initState();
    _defaultInputDecoration = InputDecoration(
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: "Họ và tên",
      floatingLabelStyle: TextStyle(color: Colors.black38),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black38)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: AppColor.red)),
    );
    _bloc = GetIt.I();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _bloc.close();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _showAvatarOption(BuildContext context, Student student) async {
    int? res = await showModalBottomSheet<int>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 100,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text("Xem ảnh đại diện"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, 2);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text("Đổi ảnh đại diện"),
                  ),
                ),
              ],
            ),
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20))));

    if (res == 1) {
      showGeneralDialog(
          context: context,
          barrierLabel: "Barrier",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 350),
          pageBuilder: (context, _, __) => student.avatar == null
              ? Image.asset("assets/images/user.jpg")
              : Image.network(student.avatar!));
    } else if (res == 2) {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      _bloc.add(EditAvatarEvent(File(image!.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColor.red,
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is EditProfileErrorState) {
            showMyAlertDialog(context, "Lỗi", state.message);
          } else {
            showMyAlertDialog(context, "Thành công", "Thay đổi thành công");
          }
        },
        listenWhen: (previous, current) =>
            current is EditProfileErrorState ||
            current is EditProfileSuccessfulState,
        buildWhen: (previous, current) => !(current is EditProfileErrorState),
        builder: (context, state) {
          if (state is EditProfileLoadingState) return LoadingWidget();
          final student = GetIt.instance<Student>();
          _phoneNumberController.text = student.phoneNumber ?? "";
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/cover.jpg",
                          width: double.infinity,
                          height: 165,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                    Positioned(
                      child: GestureDetector(
                        onTap: () {
                          _showAvatarOption(context, student);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(blurRadius: 4, color: Colors.black45)
                              ]),
                          child: CircleAvatar(
                            backgroundImage: (student.avatar == null
                                    ? AssetImage("assets/images/user.jpg")
                                    : NetworkImage(student.avatar!))
                                as ImageProvider,
                            radius: 41,
                          ),
                        ),
                      ),
                      top: 110,
                      left: MediaQuery.of(context).size.width / 2 - 45,
                    )
                  ],
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          enabled: false,
                          initialValue: student.studentId,
                          decoration: _defaultInputDecoration.copyWith(
                              labelText: "Tài khoản")),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          enabled: false,
                          initialValue: student.name,
                          decoration: _defaultInputDecoration.copyWith(
                              labelText: "Họ và tên")),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          enabled: false,
                          initialValue: student.gender == "Male" ? "Nam" : "Nữ",
                          decoration: _defaultInputDecoration.copyWith(
                              labelText: "Giới tính")),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          enabled: false,
                          initialValue: student.email,
                          decoration: _defaultInputDecoration.copyWith(
                              labelText: "Email")),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          controller: _phoneNumberController,
                          validator: (value) {
                            RegExp regex = RegExp('^[0-9]{10}\$');
                            if (regex.hasMatch(value ?? "")) {
                              return null;
                            }
                            return "Số điện thoại phải bao gồm 10 chữ số";
                          },
                          decoration: _defaultInputDecoration.copyWith(
                              labelText: "Số điện thoại",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.red)))),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text("Chỉnh sửa"),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColor.red)),
                  onPressed: () {
                    if ((_formKey.currentState?.validate() ?? false) &&
                        _phoneNumberController.text != student.phoneNumber) {
                      _bloc.add(
                          EditProfileIn4Event(_phoneNumberController.text));
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
