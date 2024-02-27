import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_firestore_app/SignUp_screen.dart';
import 'package:firebase_firestore_app/provider/signup_provider.dart';
import 'package:firebase_firestore_app/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:FirebaseOptions(
      apiKey: "AIzaSyATK3NB92UFt62Mnvf0HF-awoUR_h6R6UI",
      appId: "1:338314461238:android:998fa4e3803c264b3d9897",
      messagingSenderId: "338314461238",
      projectId: "fir-provider-3828f") );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [

        ChangeNotifierProvider(create: (context) {
          return SignUpProvider();

        },)

      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SignUpScreen(),
      ),
    );
  }
}

