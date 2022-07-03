import 'package:fakeslink/app/presentation/home/bloc/home_header_provider.dart';
import 'package:fakeslink/app/presentation/home/ui/home_common_functions.dart';
import 'package:fakeslink/app/presentation/home/ui/home_notifications.dart';
import 'package:fakeslink/app/presentation/home/ui/home_schedule.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeHeaderProvider _homeHeaderProvider;

  @override
  void initState() {
    super.initState();
    _homeHeaderProvider = HomeHeaderProvider();
  }

  @override
  void dispose() {
    // _homeHeaderProvider.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        body: ChangeNotifierProvider(
          create: (context) => _homeHeaderProvider,
          builder: (context, child) {
            final provider = Provider.of<HomeHeaderProvider>(context);
            if (provider.user == null)
              return Center(
                child: CircularProgressIndicator(),
              );
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: SliverHeaderChildDelegateImpl(paddingTop: MediaQuery.of(context).padding.top),
                  pinned: true,
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: const Text(
                      "Chức năng phổ biến:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const CommonFunction(),
                HomeSchedule(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Thông báo mới:",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Xem thêm",
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width / 2.4,
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16),
                        child: HomeNotifications()),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                  ),
                )
              ],
            );
          },
        ));
  }
}
