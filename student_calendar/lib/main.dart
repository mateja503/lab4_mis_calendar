import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_calendar/screens/calendarScreen.dart';
import 'package:student_calendar/screens/mapScreen.dart';
import 'package:student_calendar/service/notify_service.dart';
import 'package:student_calendar/utils.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await NotificationService().initNotification();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State createState () => _MyAppState();

}

class _MyAppState extends State{



  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jokes', // Change to the appropriate app title if needed
        initialRoute: '/',
        routes: {
          '/': (context) =>  const CalendarScreen(),
          '/map': (context) => MapScreen(
            event: Event(name: " ", startTime: DateTime(2025,1,1,9,0), endTime: DateTime(2025,1,1,10,0), location: const LatLng(0.0,0.0)),

          ),
        },
      ),
    );
  }
}