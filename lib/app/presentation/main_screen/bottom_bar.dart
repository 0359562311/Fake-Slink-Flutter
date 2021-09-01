import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  final Function(int) onChange;
  const MyBottomBar({Key? key, required this.onChange}) : super(key: key);
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> with TickerProviderStateMixin {

  late AnimationController _edgeController;
  late Animation<double> _edgeAnimation;
  late Tween<double> _edgeTween;
  late Animation<double> _edgeCurve;

  late AnimationController _iconController;
  late Animation<double> _iconAnimation;
  late Tween<double> _iconTween;
  late Animation<double> _iconCurve;

  int index = 0;

  final items = [
    _BottomAppBarItem("Trang chủ", Icons.apartment_rounded),
    _BottomAppBarItem("Thông báo", Icons.notifications),
    _BottomAppBarItem("Góc học tập", Icons.layers_rounded),
    _BottomAppBarItem("Tiện ích", Icons.event_available_rounded),
    _BottomAppBarItem("Cá nhân", Icons.person_pin),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _edgeController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // final Animation<double>
    _edgeCurve = CurvedAnimation(parent: _edgeController, curve: Curves.elasticOut);
    _edgeTween = Tween<double>(begin: 1.0, end: index.toDouble());
    _edgeAnimation = _edgeTween.animate(_edgeCurve)..addListener(() {
      setState(() {

      });
    });

    _iconController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    // final Animation<double>
    _iconCurve = CurvedAnimation(parent: _iconController, curve: Curves.decelerate);
    _iconTween = Tween<double>(begin: -70.0, end: 70.0);
    _iconAnimation = _iconTween.animate(_iconCurve);
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _edgeController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void animateTo(int next) {
    _edgeTween.begin = (index*2 + 1).toDouble();
    _edgeController.reset();
    _edgeTween.end = (next*2+1).toDouble();
    index = next;

    _iconController.reset();
    _iconController.forward();
    _edgeController.forward();
    widget.onChange(next);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print("rebuild");
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          height: 60,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: 60,
                child: AnimatedBuilder(
                  animation: _edgeAnimation,
                  builder: (context, child) => CustomPaint(
                    painter: _MyCustomPainter(_edgeAnimation.value*size.width/10),
                    size: Size(size.width, 60),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  width: size.width,
                  height: 60,
                  child: Row(
                      children: List.generate(items.length, (i) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        width: size.width/5,
                        height: 60,
                        child: GestureDetector(
                          onTap: (){
                            if(index != i) {
                              animateTo(i);
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: i != index,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(items[i].icon, size: 24, color: Colors.grey[600],),
                                ),
                              ),
                              Spacer(),
                              Text(items[i].title, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: i == index ? AppColor.red : AppColor.black,
                                    fontSize: 12
                                ),
                              )
                            ],
                          ),
                        ),
                      )).toList()
                  )
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -30,
          left: 0,
          width: size.width,
          child: Row(
            children: List.generate(items.length, (i){
              return Transform.translate(
                offset: Offset(0,-(_iconAnimation.value.abs())),
                child: Container(
                  width: size.width/5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == index ? AppColor.red: Colors.transparent
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    items[i].icon,
                    color: i == index ? Colors.white: Colors.transparent,
                    size: 24,
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}


class _MyCustomPainter extends CustomPainter {
  final double x0;

  _MyCustomPainter(this.x0);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()..style = PaintingStyle.fill .. color = Colors.white;
    Paint paint2 = Paint()..color=Colors.grey[500]! ..style = PaintingStyle.stroke..strokeWidth = 0.8 ..strokeCap=StrokeCap.round;

    Path path = Path()..moveTo(-5, 0)..lineTo(x0 - size.width/10 -5, 0);
    path.quadraticBezierTo(x0 - size.width/10 + 5, 0, x0 - size.width/20 - 5, 20);
    path.quadraticBezierTo(x0 - size.width/20 + 2.5, 40, x0, 40);
    path.quadraticBezierTo(x0 + size.width/20 - 2.5, 40, x0 + size.width/20 + 5, 20);
    path.quadraticBezierTo(x0 + size.width/10 - 5, 0, x0 + size.width/10 + 5, 0);
    path.lineTo(size.width+10, 0);
    path.lineTo(size.width+10, size.height+5);
    path.lineTo(-10, size.height+5);
    path.close();
    canvas.drawPath(path, paint1);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class _BottomAppBarItem {
  final String title;
  final IconData icon;

  _BottomAppBarItem(this.title, this.icon);
}