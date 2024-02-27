import 'package:firebase_firestore_app/provider/signup_provider.dart';
import 'package:firebase_firestore_app/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    phoneNoController.dispose();
    addressController.dispose();
    super.dispose();
  }


  Future<void> registerUserTocallInButton() async {
    if (formkey.currentState!.validate()) {
      // Show the loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
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
                Text('Registering user...'),
              ],
            ),
          );
        },
      );

      // Perform the registration operation
      await context.read<SignUpProvider>().registerUser(
        context,
        emailController.text.trim().toString(),
        passwordController.text.trim().toString(),
        nameController.text.trim().toString(),
      );

      await context.read<SignUpProvider>().getUserDetail();

        // Check for registrationSuccessful and navigate to the next screen
        if (context.read<SignUpProvider>().registrationSuccessful) {
          // Close the loading dialog
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
          print('Form is valid');
          // Perform additional logic after successful registration here
        }

      // Optionally handle errors here
      // Note: If there are errors during registration, they won't be caught here
    } else {
      print('Name Error: ${nameController.text}');
      print('Email Error: ${emailController.text}');
      print('Password Error: ${passwordController.text}');
      print('Form is not valid');
    }
  }







  // Future<void> registerUserTocallInButton() async {
  //   if (formkey.currentState!.validate()) {
  //
  //     await context.read<SignUpProvider>().registerUser(
  //         context,
  //         emailController.text.trim().toString(),
  //         passwordController.text.trim().toString(),
  //         nameController.text.trim().toString());
  //     if (context.read<SignUpProvider>().registrationSuccessful) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => SignInScreen()));
  //     }
  //
  //     print('Form is valid');
  //     // Perform registration logic here
  //   } else {
  //     print('Name Error: ${nameController.text}');
  //     print('Email Error: ${emailController.text}');
  //     print('Password Error: ${passwordController.text}');
  //
  //     print('Form is not valid');
  //   }
  // }

  @override
  Widget build(BuildContext context) {



    print('ddddddddddddddddd');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                // autovalidateMode: AutovalidateMode.always,
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Registeration',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.blue,
                        ),
                        Positioned(
                            top: 25,
                            right: 0,
                            child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                )))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: 'Enter name',
                          hintText: 'Enter name',
                          fillColor: Colors.grey.shade300,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder()),
                      autovalidateMode: AutovalidateMode.always,
                      //aply more condition
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "plese enter user name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
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
                    TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller: cPasswordController,
                        decoration: InputDecoration(
                            labelText: 'Cpassword',
                            filled: true,
                            hintText: 'Enter cpassword',
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter confirm password";
                          }

                          return (value == passwordController.text.trim())
                              ? null // Passwords match
                              : 'Passwords do not match';
                        }),
                    SizedBox(height: 16),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: ContinuousRectangleBorder(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 160, vertical: 20)),
                        onPressed: () {
                          registerUserTocallInButton();
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to the sign-in screen
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return SignInScreen();
                          },
                        ));
                      },
                      child: Text('Already have an account? Sign in'),
                    ),
                  ],
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
