import 'package:fakeslink/app/presentation/profile/bloc/profile_bloc.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_event.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showFingerprintDialog(BuildContext context, ProfileBloc bloc) {
  String password = "";
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 350),
    context: context,
    pageBuilder: (context, __, ___) {
      print("TanKiem: resize on general Dialog");
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24),
          height: 150,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Text(
                  "Nhập mật khẩu để xác thực",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Mật khẩu"),
                  obscureText: true,
                  onChanged: (val) => password = val,
                ),
                TextButton(
                  onPressed: () {
                    if (password.isNotEmpty) {
                      bloc.add(ProfileSetUpFingerprintEvent(password));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColor.red),
                  ),
                )
              ],
            ),
          ),
          // margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
