import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_bloc.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_event.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance()..add(ProfileInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is ProfileLoadingState)
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.black,
              strokeWidth: 5,
            ),
          );
        else if (state is ProfileErrorState) {
          return Center(
              child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Chạm để thử lại"),
            ),
            onTap: () {
              _bloc.add(ProfileInitEvent());
            },
          ));
        }
        return Column(
          children: [_UpperLayout(student: GetIt.instance()), _BelowLayout()],
        );
      },
    ));
  }
}

class _BelowLayout extends StatelessWidget {
  const _BelowLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: AppColor.background,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(blurRadius: 1, color: Colors.black12),
                  BoxShadow(
                      blurRadius: 1,
                      color: Colors.black12,
                      offset: Offset(0, 1)),
                ]),
            child: Column(
              children: List.generate(
                7,
                (index) {
                  if (index % 2 == 1)
                    return Container(
                      height: 1,
                      color: Colors.black38,
                      width: double.infinity,
                    );
                  switch (index ~/ 2) {
                    case 0:
                      return _Items(
                          iconData: Icons.person,
                          color: Colors.blue,
                          title: "Thông tin cá nhân",
                          nextRoute: "nextRoute");
                    case 1:
                      return _Items(
                          iconData: Icons.event_available_outlined,
                          color: Colors.red,
                          title: "Lịch thi, sự kiện sắp tới",
                          nextRoute: "nextRoute");
                    case 2:
                      return _Items(
                          iconData: Icons.mail,
                          color: Colors.orange,
                          title: "Đang chờ phản hồi",
                          nextRoute: "nextRoute");
                    default:
                      return _Items(
                          iconData: Icons.fingerprint,
                          color: Colors.red,
                          title: "Cài đặt vân tay/FaceID",
                          nextRoute: "nextRoute");
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(blurRadius: 1, color: Colors.black12),
                  BoxShadow(
                      blurRadius: 1,
                      color: Colors.black12,
                      offset: Offset(0, 1)),
                ]),
            child: _Items(
                iconData: Icons.logout_rounded,
                color: Colors.black26,
                title: "Đăng xuất",
                nextRoute: AppRoute.login),
          )
        ],
      ),
    ));
  }
}

class _Items extends StatefulWidget {
  final IconData iconData;
  final Color color;
  final String title;
  final String nextRoute;
  const _Items(
      {Key? key,
      required this.iconData,
      required this.color,
      required this.title,
      required this.nextRoute})
      : super(key: key);

  @override
  __ItemsState createState() => __ItemsState();
}

class __ItemsState extends State<_Items> {
  double _opacity = 1;

  Color _getColor(Color color) =>
      _opacity == 1 ? color : color.withOpacity(_opacity);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          _opacity = 0.5;
        });
        Future.delayed(Duration(milliseconds: 120)).whenComplete(() async {
          setState(() {
            _opacity = 1;
          });
          if (widget.nextRoute == AppRoute.login) {
            Widget confirmButton = TextButton(
              child: Text("Thoát"),
              onPressed: () {
                Navigator.pop(context, "yes");
              },
            );

            Widget cancelButton = TextButton(
              child: Text("Hủy"),
              onPressed: () {
                Navigator.pop(context, "no");
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Đăng xuất"),
              content: Text("Bạn có đồng ý đăng xuất?"),
              actions: [
                cancelButton,
                confirmButton,
              ],
            );

            // show the dialog
            final res = await showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
            if (res == "yes") {
              GetIt.instance<SharePreferencesUtils>().clearSession();
              Hive.deleteBoxFromDisk("user");
              Hive.deleteBoxFromDisk("schedules");
              Hive.deleteBoxFromDisk("notifications");
              Hive.deleteBoxFromDisk("register");
              Hive.deleteBoxFromDisk("administrativeClassDetails");
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoute.login, (route) => false);
            }
          }
          // await Navigator.of(context).pushNamed(widget.nextRoute);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Icon(
              widget.iconData,
              color: _getColor(widget.color),
              size: 24,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 14, color: _getColor(Colors.black)),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: _getColor(Colors.black12),
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}

class _UpperLayout extends StatelessWidget {
  final Student student;
  const _UpperLayout({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image.asset(
              "assets/images/cover.jpg",
              width: double.infinity,
              height: 165,
              fit: BoxFit.cover,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(right: 16, top: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[50],
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.blue[900],
                  ),
                )),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                student.name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "MSV: ${student.studentId}  Lớp: ${student.administrativeClass.administrativeClassId}",
                  style: TextStyle(color: AppColor.black, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4, color: Colors.white),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black45)]),
            child: CircleAvatar(
              backgroundImage: (student.avatar == null
                  ? AssetImage("assets/images/user.jpg")
                  : NetworkImage(student.avatar!)) as ImageProvider,
              radius: 41,
            ),
          ),
          top: 110,
          left: MediaQuery.of(context).size.width / 2 - 45,
        )
      ],
    );
  }
}
