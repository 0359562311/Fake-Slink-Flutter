import 'dart:async';

import 'package:fakeslink/app/presentation/login/bloc/login_bloc.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_event.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:fakeslink/core/custom_widgets/custom_dialog.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool showPassword;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  late LoginBloc _bloc;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    showPassword = false;
    _bloc = GetIt.I();
    _checkConnectivity();
  }

  Future _checkConnectivity() async {
    await Future.delayed(Duration(seconds: 2));
    if (!GetIt.instance<NetworkInfo>().isConnecting) {
      showMyAlertDialog(
          context, "Lỗi kết nối", "Kiểm tra lại kết nối internet của bạn");
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer(
          listener: (context, state) {
            if (state is LoginFailState) {
              showMyAlertDialog(context, "Lỗi đăng nhập", state.message);
            } else if (state is LoginSuccessfulState) {
              Navigator.of(context).pushReplacementNamed(AppRoute.main);
            }
          },
          listenWhen: (old, notOlder) {
            return notOlder is LoginFailState ||
                notOlder is LoginSuccessfulState;
          },
          bloc: _bloc,
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Container(
                        height: size.height * 0.25,
                        width: size.width * 0.4,
                        // color: Colors.blue,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/ptit.png'),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(height: 10),
                      //Account
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: usernameController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Không được bỏ trống";
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_pin,
                                color: Colors.grey[400],
                                size: 23,
                              ),
                              labelText: 'Tài khoản',
                              labelStyle: TextStyle(
                                  fontSize: 15, color: Colors.black),
                              alignLabelWithHint: true,
                              hintText: 'Tài khoản',
                              hintStyle: TextStyle(
                                  fontSize: 15, color: Colors.grey[400]!),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.red[900]!)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.red[900]!)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.red[900]!)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey[400]!))),
                        ),
                      ),
                      //Password
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8)
                              return "Mật khẩu phải có ít nhất 8 ký tự";
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[400]!,
                              size: 23,
                            ),
                            suffixIcon: showPassword
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showPassword = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey[500]!,
                                      size: 23,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showPassword = true;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                            labelText: 'Mật khẩu',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            hintText: 'Mật khẩu',
                            alignLabelWithHint: false,
                            hintStyle: TextStyle(
                                fontSize: 15, color: Colors.grey[400]!),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.red[900]!)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!)),
                          ),
                          obscureText: showPassword ? false : true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: SizedBox(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ??
                                  false) {
                                _bloc.add(LoginWithUsernameEvent(
                                    usernameController.text,
                                    passwordController.text));
                              }
                            },
                            child: Text(
                              'Đăng nhập',
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // <-- Radius
                                ),
                                primary: Colors.red[900],
                                onPrimary: Colors.white,
                                textStyle: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.fingerprint,
                    color: AppColor.red,
                    size: 50,
                  ),
                  onPressed: () {
                    _bloc.add(LoginWithFingerprintEvent());
                  },
                )
              ]),
            );
          }),
    );
  }
}
