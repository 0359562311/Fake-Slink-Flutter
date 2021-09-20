import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:flutter/material.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationDetails details = ModalRoute.of(context)?.settings.arguments! as NotificationDetails;
    return Scaffold(
      body: Center(
        child: Text(details.details),
      ),
    );
  }
}
