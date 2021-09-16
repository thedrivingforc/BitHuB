import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:study_material_app/Animation/ComingSoon.dart';
import 'package:study_material_app/BIT_Bus/bus.dart';
import 'package:study_material_app/Books/ebookHome.dart';
import 'package:study_material_app/Books/notesHome.dart';
import 'package:study_material_app/Books/syllabus.dart';
import 'package:study_material_app/Videos/module.dart';
import 'package:study_material_app/screen/passwordReset.dart';
import 'package:study_material_app/screen/updateDetails.dart';
import 'Holiday Calendar/HolidayPage.dart';
import 'package:study_material_app/Attendance%20and%20Practice/graphPage.dart';
import 'package:study_material_app/Attendance%20and%20Practice/practiceHome.dart';
import 'package:study_material_app/Books/aids.dart';
import 'package:study_material_app/Books/bookHome.dart';
import 'package:study_material_app/Maps/mapsHome.dart';
import 'package:study_material_app/Videos/videoHome.dart';
import 'package:study_material_app/forms.dart';
import 'package:study_material_app/screen/FrontPage.dart';
import 'package:study_material_app/screen/loginPage.dart';
import 'package:study_material_app/screen/profilePage.dart';
import 'package:study_material_app/screen/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_material_app/screen/signUpDetails.dart';
import 'screen/FrontPage.dart';
import 'screen/loginPage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:study_material_app/screen/aboutUs.dart';
import 'user.dart';

String finalEmail;

Widget home = CircularProgressIndicator();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', //title
    'This channel is used for important notifications.', //description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SignUpPage.id: (context) => SignUpPage(),
        LoginPage.id: (context) => LoginPage(),
        PasswordReset.id: (context) => PasswordReset(),
        FrontPage.id: (context) => FrontPage(),
        ProfilePage.id: (context) => ProfilePage(),
        SignupPageDetails.id: (context) => SignupPageDetails(),
        PracticeHome.id: (context) => PracticeHome(),
        BookHome.id: (context) => BookHome(),
        MapsHome.id: (context) => MapsHome(),
        VideoHome.id: (context) => VideoHome(),
        GraphPage.id: (context) => GraphPage(),
        HolidayPage.id: (context) => HolidayPage(),
        UserForm.id: (context) => UserForm(User('', 0, 0)),
        Aids.id: (context) => Aids(),
        ModulePage.id: (context) => ModulePage(),
        UpdateScreen.id: (context) => UpdateScreen(),
        Bus.id: (context) => Bus(),
        EbookHome.id: (context) => EbookHome(),
        NotesHome.id: (context) => NotesHome(),
        ComingSoon.id: (context) => ComingSoon(),
        AboutUs.id: (context) => AboutUs(),
        SyllabusScreen.id: (context) => SyllabusScreen(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final webView = FlutterWebviewPlugin();

  @override
  void initState() {
    getValidation().whenComplete(() {
      home = finalEmail == null ? LoginPage() : FrontPage();
    });
    super.initState();
  }

  @override
  void dispose() {
    webView.dispose();
    super.dispose();
  }

  Future getValidation() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String email = sharedPref.getString('email');
    setState(() {
      finalEmail = email;
    });
  }

  Widget build(BuildContext context) {
    return home;
  }
}
