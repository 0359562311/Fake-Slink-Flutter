import 'package:fakeslink/core/const/app_routes.dart';
import 'package:flutter/material.dart';

class CommonFunction extends StatelessWidget {
  const CommonFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_FunctionItem> _items = [
      _FunctionItem(Colors.blue[100]!.withOpacity(0.5), Colors.blue, Icons.schedule, "Thời khoá biểu", AppRoute.listSchedules),
      _FunctionItem(Colors.orange[100]!.withOpacity(0.5), Colors.orange, Icons.people_alt_rounded, "Lớp tín chỉ", AppRoute.listRegisterableClass),
      _FunctionItem(Colors.purple[100]!.withOpacity(0.5), Colors.purple, Icons.pie_chart_rounded, "Kết quả học tập", AppRoute.result),
      _FunctionItem(Colors.red[100]!.withOpacity(0.5), Colors.red, Icons.person, "Lớp hành chính", AppRoute.administrativeClass),
    ];
    return SliverGrid.count(crossAxisCount: 2,
      childAspectRatio: 3,
      children: List.generate(4, (index){
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, _items[index].nextRoute);
          },
          child: Container(
            height: 50,
            margin: index.isEven?EdgeInsets.only(left: 16,right: 8):EdgeInsets.only(right: 16,left: 8),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: _items[index].light,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Icon(_items[index].iconData,color: _items[index].primary,size: 18,),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(_items[index].name,maxLines: 2,),
                  ),
                )
              ],
            ),
          ),
        );
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

  const _FunctionItem(this.light, this.primary, this.iconData, this.name, this.nextRoute);
}