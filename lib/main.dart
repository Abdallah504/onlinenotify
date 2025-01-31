import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onlinenotify/logic/storage-provider.dart';
import 'package:onlinenotify/screens/home-screen.dart';
import 'package:onlinenotify/screens/notify-screen.dart';
import 'package:onlinenotify/screens/uploading/pick-screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'api/firebase-api.dart';
import 'firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://sidsvtqowqyqzjzrvlrf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNpZHN2dHFvd3F5cXpqenJ2bHJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgzMzk0MzIsImV4cCI6MjA1MzkxNTQzMn0.spXS1tojc1LVg5s-NRiHFQHYZq3fKwQMx89_CLfYuTY',
  );
  FirebaseApi().initNotify();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context)=>StorageProvider()..getAllImages() ,
    child:  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PickScreen(),
      navigatorKey: navigatorKey,
      routes: {
        NotifyScreen.route:(context)=>NotifyScreen()
      },
    ),
    );
  }
}

