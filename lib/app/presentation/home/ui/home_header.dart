import 'package:fakeslink/app/presentation/home/bloc/home_header_provider.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SliverHeaderChildDelegateImpl extends SliverPersistentHeaderDelegate {
  final double _maxExtent = 150;
  final double _minExtent = 80;
  const SliverHeaderChildDelegateImpl();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var _provider = Provider.of<HomeHeaderProvider>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: maxExtent - shrinkOffset < 80 ? 80 : maxExtent - shrinkOffset,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          SizedBox(
            child: Container(color: AppColor.red,),
            width: MediaQuery.of(context).size.width,
            height: maxExtent - 40 - shrinkOffset < 0
                ? 0
                : maxExtent - 40 - shrinkOffset,
          ),
          Positioned(
            bottom: 0,
            left: shrinkOffset > _maxExtent-_minExtent ? 0 : (-shrinkOffset + _maxExtent-_minExtent) / 4,
            right: shrinkOffset > _maxExtent-_minExtent ? 0 : (-shrinkOffset + _maxExtent-_minExtent) / 4,
            height: 80,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(maxExtent - shrinkOffset < 80 ? 0 : 6)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, offset: Offset(0, 2), color: Colors.grey)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: (_provider.user?.avatar != null ?
                        NetworkImage(_provider.user!.avatar!):
                        const AssetImage("assets/images/user.jpg")) as ImageProvider
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _provider.user?.name??"N/A",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Ma sinh vien: ${_provider.user?.studentId??""}",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(text: TextSpan(
                            children: [
                              TextSpan(text: (_provider.gpa?.gpa.toStringAsFixed(2)??"N/A").toString(),
                                  style: TextStyle(
                                      color: AppColor.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              TextSpan(text: "/4",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87
                                  )
                              )
                            ]
                        )),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black87
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 8
                          ),
                          alignment: Alignment.center,
                          child: Text("GPA",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}