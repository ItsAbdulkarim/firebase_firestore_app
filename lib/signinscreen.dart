import 'package:firebase_firestore_app/Homescreen.dart';
import 'package:firebase_firestore_app/SignUp_screen.dart';
import 'package:firebase_firestore_app/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void lognUserMethod() async{
    if (formkey.currentState!.validate()) {
      showDialog(context: context, builder: (context) {

        return AlertDialog(
          title:Text('Please wait'),
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


      },);
// Perform the login operation
     await context.read<SignUpProvider>().signInUser( context,emailController.text.trim().toString(),
          passwordController.text.trim().toString());







      print('Form is valid');
      if(context.read<SignUpProvider>().registrationSuccessful){

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {

          return HomeScreen();
        },));
      }

      // Perform registration logic here
    } else {
      print('Email Error: ${emailController.text}');
      print('Password Error: ${passwordController.text}');

      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            // autovalidateMode: AutovalidateMode.always,
            key: formkey,
            child: ListView(

              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Login Screen',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Enter email',
                      filled: true,
                      hintText: 'Enter email',
                      fillColor: Colors.grey.shade300,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder()),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "plese enter user email";
                    }
                    // Simple email format validation
                    if (!RegExp(
                            r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      hintText: 'Enter password',
                      fillColor: Colors.grey.shade300,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "plese enter password";
                    }
                    if (value.length < 6) {
                      return 'Password should be 6 characters or more\none special character,\n one capital letter, \n and one number';
                    }
                    if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                        .hasMatch(value)) {
                      return 'Password should be 6 characters or more\none special character,\n one capital letter, \n and one number';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: ContinuousRectangleBorder(),
                      padding: EdgeInsets.symmetric(vertical: 15)

                    ),
                    onPressed: () {
                      lognUserMethod();



                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the sign-in screen
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {

                      return SignUpScreen();
                    },));
                  },
                  child: Text(" have'nt an account? Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
