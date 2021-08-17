import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool showPassword;
  late TextEditingController emailController ;
  late TextEditingController passwordController ;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    showPassword = false;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                height: size.height * 0.25,
                width: size.width * 0.4,
                // color: Colors.blue,
                decoration: const BoxDecoration(
                    image:  DecorationImage(
                        image: AssetImage(
                            'assets/images/ptit.png'),
                        fit: BoxFit.fill)),
              ),
              SizedBox(height: 10),
              //Account
              Padding(padding: const  EdgeInsets.symmetric( vertical: 10, horizontal: 20),
                child: SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: emailController,
                    obscureText: false,
                    validator: (value){
                      if(value == null || value.isEmpty) {
                        return "Account mustn't be emptied.";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_pin,
                          color: Colors.grey[400],
                          size: 23,
                        ),
                        labelText: '*Account',
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black
                        ),
                        hintText: 'Account',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400]!
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide( color: Colors.grey[400]!)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide( width: 1 ,color: Colors.red[900]!)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(width: 1, color: Colors.grey[400]!)
                        )
                    ),
                  ),
                ),
              ),
              //Password
              Padding(padding: const  EdgeInsets.symmetric( vertical: 10, horizontal: 20),
                child: SizedBox(
                  height: 55.0,
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value){
                      if(value == null || value.isEmpty) {
                        return "Password mustn't be emptied.";
                      }else if(value.length < 8) return "Password must be > 8 characters";
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
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[400]!
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red[900]!)
                      ),
                      enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey[400]!)
                      ),
                    ),
                    obscureText: showPassword ? false : true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal:  20),
                child: SizedBox(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {  },
                    child: Text(
                      'Login',
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 18,
                        )
                    ),

                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
