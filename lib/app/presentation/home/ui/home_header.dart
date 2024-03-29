import 'package:fakeslink/app/presentation/home/bloc/home_header_provider.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class SliverHeaderChildDelegateImpl extends SliverPersistentHeaderDelegate {
  double _maxExtent = 180;
  double _minExtent = 80;

  SliverHeaderChildDelegateImpl({required double paddingTop}) {
    _maxExtent = 180 + paddingTop;
    _minExtent = 80 + paddingTop;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var _provider = Provider.of<HomeHeaderProvider>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: maxExtent - shrinkOffset < minExtent ? minExtent : maxExtent - shrinkOffset,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width,
            height: maxExtent - 40 < 0 ? 0 : maxExtent - 40,
            top: -shrinkOffset,
            child: Container(
              color: AppColor.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Text(
                    "Fake S-Link",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            bottom: 0,
            left: shrinkOffset > _maxExtent - _minExtent
                ? 0
                : (-shrinkOffset + _maxExtent - _minExtent - 30) / 4,
            right: shrinkOffset > _maxExtent - _minExtent
                ? 0
                : (-shrinkOffset + _maxExtent - _minExtent - 30) / 4,
            height: shrinkOffset > _maxExtent - _minExtent
                ? _minExtent
                : 80,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(maxExtent - shrinkOffset < 80 ? 0 : 6)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, offset: Offset(0, 2), color: Colors.grey)
                  ]),
              child: Column(
                children: [
                  SizedBox(
                    height: shrinkOffset > _maxExtent - _minExtent
                        ? _minExtent - 80
                        : 0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: (_provider.user?.avatar != null &&
                                        GetIt.instance<NetworkInfo>().isConnecting
                                    ? NetworkImage(_provider.user!.avatar!)
                                    : const AssetImage("assets/images/user.jpg"))
                                as ImageProvider),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _provider.user?.name ?? "N/A",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "Mã sinh viên: ${_provider.user?.studentId ?? ""}",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: (_provider.user?.gpa.toStringAsFixed(2) ??
                                          "N/A")
                                      .toString(),
                                  style: TextStyle(
                                      color: AppColor.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "/4",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87))
                            ])),
                            const SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87),
                              padding:
                                  EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                              alignment: Alignment.center,
                              child: Text(
                                "GPA",
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
