import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            GestureDetector(
              onTap: () async {
                GetIt.instance<SharePreferencesUtils>().clearSession();
                Hive.deleteBoxFromDisk("user");
                Hive.deleteBoxFromDisk("schedules");
                Hive.deleteBoxFromDisk("notifications");
                Hive.deleteBoxFromDisk("register");
                Hive.deleteBoxFromDisk("administrativeClassDetails");
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(AppRoute.login, (route) => false);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: AppColor.black.withOpacity(_opacity),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Đăng xuất",
                  style: TextStyle(
                      color: Colors.white.withOpacity(_opacity),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
