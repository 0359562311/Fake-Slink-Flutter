import 'package:fakeslink/app/presentation/home/ui/home_view.dart';
import 'package:fakeslink/app/presentation/main_screen/bottom_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _index = 0;
  late List<Widget> _screens;

  void initState() {
    super.initState();
    _screens = [HomeView(), Scaffold(), Scaffold(), Scaffold(), Scaffold()];
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: IndexedStack(
                children: _screens,
                index: _index,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: 110,
              child: MyBottomBar(
                onChange: (index) {
                  setState(() {
                    _index = index;
                  });
                },
              ),
            )
          ]
        ),
      ),
    );
  }
}
