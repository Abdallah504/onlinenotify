import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({super.key});
  static const route = '/notify';

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as  RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify Screen'),
      ),
      body: Center(
        child: Text('${message.notification!.title}'),
      ),
    );
  }
}
