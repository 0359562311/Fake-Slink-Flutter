import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _opacity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            setState(() {
              _opacity = 0.7;
            });
            Future.delayed(Duration(milliseconds: 200)).whenComplete(() {
              // Navigator.pushNamed(context, AppRoute.listSchedules);
              setState(() {
                _opacity = 1;
              });
            });
          },
          onTapCancel: () {
            setState(() {
              _opacity = 1;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: AppColor.black.withOpacity(_opacity),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Ngày mai",
              style: TextStyle(
                  color: Colors.white.withOpacity(_opacity),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
