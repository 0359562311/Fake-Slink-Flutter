import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
      slivers: [
          SliverPersistentHeader(
            delegate: SliverHeaderChildDelegateImpl(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Text(
                "Chức năng:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Text(index.toString())
            ),
          )
        ],
      )
    );
  }
}

class SliverHeaderChildDelegateImpl extends SliverPersistentHeaderDelegate {
  final double _maxExtent = 150;
  final double _minExtent = 80;
  SliverHeaderChildDelegateImpl();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: maxExtent - shrinkOffset < 80 ? 80 : maxExtent - shrinkOffset,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          SizedBox(
            child: Container(color: Colors.red[900],),
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
                children: [
                  Container(
                    width: 80,
                    height: 100,
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        "assets/images/icon_user.png",
                        color: Colors.blue,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Nguyen Kiem Tan",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "Vai trò: ${"Admin"}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _maxExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}