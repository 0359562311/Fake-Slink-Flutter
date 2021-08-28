import 'package:flutter/material.dart';

class CommonFunction extends StatelessWidget {
  const CommonFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(crossAxisCount: 2,
      childAspectRatio: 3,
      children: List.generate(4, (index){
        return Container(
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
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Icon(Icons.book,color: Colors.blue,size: 18,),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text("Thoi khoa bieu  ss",maxLines: 2,),
                ),
              )
            ],
          ),
        );
      }),
      mainAxisSpacing: 12,
    );
  }
}
