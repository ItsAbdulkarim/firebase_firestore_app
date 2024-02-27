import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_firestore_app/futurescreen.dart';
import 'package:firebase_firestore_app/provider/signup_provider.dart';
import 'package:firebase_firestore_app/signinscreen.dart';
import 'package:firebase_firestore_app/tasklistscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  TextEditingController descriptonCotroller = TextEditingController();
  TextEditingController titleCotroller = TextEditingController();
  final Formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    descriptonCotroller.dispose();
    titleCotroller.dispose();
    super.dispose();
  }

  void savedData() async{
    if (Formkey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please wait'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
                SizedBox(height: 20),
                Text('Login user...'),
              ],
            ),
          );
        },
      );

      await context.read<SignUpProvider>().savedTitleAndDiscription(
          context,
          titleCotroller.text.trim().toString(),
          descriptonCotroller.text.trim().toString());
print('dddddddffffddddd${titleCotroller.text.toString()}');



    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),
                accountName: Consumer<SignUpProvider>(
                  builder: (context, value, child) {
                    return Text(value.documentSnapshot['name']);
                  },
                ), // Replace with the user's name
                accountEmail: Consumer<SignUpProvider>(
                  builder: (context, value, child) {
                    return Text(value.documentSnapshot['email']);
                  },
                ), // Replace with the user's email
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors
                      .redAccent, // Replace with the user's profile picture
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Handle item 1 tap
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Handle item 2 tap
                  Navigator.pop(context); // Close the drawer
                },
              ),
              // Add more ListTile widgets for additional items
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('HomeScreen'),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SignInScreen();
                    },
                  ));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Colors.black,
                ))
          ],
          centerTitle: true,
          backgroundColor: Colors.teal,
          elevation: 9,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
          toolbarHeight: 80,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: Formkey,
            child: ListView(
              children: [
                TextFormField(
                  controller: titleCotroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'enter title',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please write title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: descriptonCotroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'enter some things',
                    border: InputBorder.none,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please write some thing';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: ContinuousRectangleBorder(),
                        padding: EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () {
savedData();
                    },
                    child: Text(
                      'save',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),


                SizedBox(
                  height: 20,
                ),
                Text('this is through streambuilder'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: ContinuousRectangleBorder(),
                        padding: EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () async{
                      await
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  return TaskListScreen();
},));
                    },
                    child: Text(
                      'see task',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),

                SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: ContinuousRectangleBorder(),
                        padding: EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () async{
                      await
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return FutureBuilderScreen();
                      },));
                    },
                    child: Text(
                      'see future buider',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
