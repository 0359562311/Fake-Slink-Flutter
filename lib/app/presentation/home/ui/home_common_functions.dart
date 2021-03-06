import 'package:fakeslink/core/const/app_routes.dart';
import 'package:flutter/material.dart';

class CommonFunction extends StatelessWidget {
  const CommonFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_FunctionItem> _items = [
      _FunctionItem(Colors.blue[100]!.withOpacity(0.5), Colors.blue,
          Icons.schedule, "Thời khoá biểu", AppRoute.listSchedules),
      _FunctionItem(
          Colors.orange[100]!.withOpacity(0.5),
          Colors.orange,
          Icons.people_alt_rounded,
          "Lớp tín chỉ",
          AppRoute.listRegisterableClass),
      _FunctionItem(Colors.purple[100]!.withOpacity(0.5), Colors.purple,
          Icons.pie_chart_rounded, "Kết quả học tập", AppRoute.result),
      _FunctionItem(Colors.red[100]!.withOpacity(0.5), Colors.red, Icons.person,
          "Lớp hành chính", AppRoute.administrativeClass),
    ];
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: List.generate(4, (index) {
        return _HomeCommonItem(
            callback: () {
              Navigator.pushNamed(context, _items[index].nextRoute);
            },
            index: index,
            item: _items[index]);
      }),
      mainAxisSpacing: 12,
    );
  }
}

class _FunctionItem {
  final Color light;
  final Color primary;
  final IconData iconData;
  final String name;
  final String nextRoute;

  const _FunctionItem(
      this.light, this.primary, this.iconData, this.name, this.nextRoute);
}

class _HomeCommonItem extends StatefulWidget {
  final Function() callback;
  final int index;
  final _FunctionItem item;
  const _HomeCommonItem(
      {Key? key,
      required this.callback,
      required this.index,
      required this.item})
      : super(key: key);

  @override
  _HomeCommonItemState createState() => _HomeCommonItemState();
}

class _HomeCommonItemState extends State<_HomeCommonItem> {
  double _opacity = 1;

  Color _getColor(Color color) {
    if (_opacity == 1) return color;
    return color.withOpacity(_opacity);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _opacity = 0.5;
        });
      },
      onTapUp: (details) {
        Future.delayed(Duration(milliseconds: 200)).whenComplete(() {
          setState(() {
            _opacity = 1;
          });
          widget.callback();
        });
      },
      onTapCancel: () {
        setState(() {
          _opacity = 1;
        });
      },
      child: Container(
          height: 50,
          margin: widget.index.isEven
              ? EdgeInsets.only(left: 16, right: 8)
              : EdgeInsets.only(right: 16, left: 8),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: _getColor(Colors.white),
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: _getColor(widget.item.light),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  widget.item.iconData,
                  color: _getColor(widget.item.primary),
                  size: 18,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.item.name,
                    maxLines: 2,
                    style: TextStyle(color: _getColor(Colors.black)),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
