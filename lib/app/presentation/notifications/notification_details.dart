import 'package:flutter/material.dart';

class NotificationDetails extends StatelessWidget {
  const NotificationDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var details = (ModalRoute.of(context)?.settings.arguments as Map)['details'];
    var details = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: Center(
        child: Text(details.toString()),
      ),
    );
  }
}
