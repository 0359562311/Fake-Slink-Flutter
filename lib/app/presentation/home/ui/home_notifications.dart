import 'package:carousel_slider/carousel_slider.dart';
import 'package:fakeslink/app/domain/entities/notification.dart' as n;
import 'package:fakeslink/app/presentation/home/bloc/home_notifications_bloc.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeNotifications extends StatefulWidget {
  const HomeNotifications({Key? key}) : super(key: key);

  @override
  _HomeNotificationsState createState() => _HomeNotificationsState();
}

class _HomeNotificationsState extends State<HomeNotifications> {

  late HomeNotificationsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance()..add(HomeNotificationsEvent.init);
  }
  
  void navigateToDetail(context, n.Notification notification){
    Navigator.of(context).pushNamed(AppRoute.notificationDetails,arguments: notification.details);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNotificationsBloc, HomeNotificationsState>(
      bloc: _bloc,
      builder: (context, state){
        if(state is HomeNotificationsLoadingState)
          return Center(child: CircularProgressIndicator(
            strokeWidth: 5,
            color: AppColor.black,
          ),);
        final notifications = (state as HomeNotificationsSuccessfulState).notifications;
        return CarouselSlider(
            items: notifications.length == 0 ? [Center(child: Text("Không có thông báo mới"))] 
            :notifications.map((e) {
              return GestureDetector(
              onTap: (){
                navigateToDetail(context, e);
              },
              child: Column(
                  children: [
                    Expanded(
                      child: Container(margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage("assets/images/notification.png"),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(e.details.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
            );
            }).toList(),
            options: CarouselOptions(
              height: 120,
              aspectRatio: 16/10,
              viewportFraction: 0.5,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              disableCenter: true,
              scrollDirection: Axis.horizontal,
            )
        );
      },
    );
  }
}
