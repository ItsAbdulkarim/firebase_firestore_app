import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../signinscreen.dart';

class SignUpProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool registrationSuccessful = false;

  bool isLoading = false;

  //this is for get access user data
  late DocumentSnapshot
      documentSnapshot; //In summary, a DocumentSnapshot represents the data of a specific document, while a CollectionReference represents a reference to a collection, allowing you to perform operations on the documents within that collection.
  late CollectionReference collectionReference;

  Future<void> registerUser(
    BuildContext context,
    String email,
    password,
    name,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        //save data to firestore

        await firestore
            .collection('User')
            .doc(user.uid)
            .set({'name': name, 'email': email, 'password': password});
      }
      Fluttertoast.showToast(
        msg: 'User registered successfully! UID: ${user!.uid}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      registrationSuccessful = true;
    } on FirebaseException catch (e) {
      registrationSuccessful = false;

      print('Error registering user: $e');
      Fluttertoast.showToast(
        msg: 'Error registering user: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading = false;

      notifyListeners(); // Notify listeners that loading state has changed
      Navigator.pop(context); //
    }
  }
///////////////////////////////////////////////////
  //user signin
  Future<void> signInUser(BuildContext context, String email, password) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      Fluttertoast.showToast(
        msg: 'User successfully logged in! UID: ${user!.uid}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      registrationSuccessful = true;
    } on FirebaseException catch (e) {
      registrationSuccessful = false;
      print('Error logging in: $e');
      Fluttertoast.showToast(
        msg: 'Error logging in: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    }
  }

  Future<void> getUserDetail() async {

    // DocumentSnapshot: this is defination
    //
    // Represents a snapshot of a single document in a Firestore database.
    // Contains data and metadata about the document.
    // Obtained when you fetch a specific document.
    String uid = firebaseAuth.currentUser!.uid;
    documentSnapshot = await firestore.collection('User').doc(uid).get();
    notifyListeners();
  }

  Future<void> savedTitleAndDiscription(
      BuildContext context, String title, discription) async {
    try {
      isLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 10));

      var taskref = await firestore
          .collection('userentry')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('userentry')
          .doc();
      taskref.set({
        'userId': taskref.id,
        'title': title,
        'description': discription,
        // Other task details
      });

      Fluttertoast.showToast(
        msg: 'Task successfully by: ${firebaseAuth.currentUser!.email}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      registrationSuccessful = true;
    } on FirebaseException catch (e) {
      registrationSuccessful = false;

      print('Error registering user: $e');
      Fluttertoast.showToast(
        msg: 'Error registering user: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading = false;

      notifyListeners(); // Notify listeners that loading state has changed
      Navigator.pop(context); //
    }
  }

  Stream<QuerySnapshot> showTaskOnScreen() {
    return firestore
        .collection('userentry')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('userentry')
        .snapshots();
  }


  //through future builder
  Future<QuerySnapshot> showTaskOnScreenFuture() async {
    // if any probelm occure see the notes on deesktop
    collectionReference = await firestore.collection('userentry').doc(firebaseAuth.currentUser!.uid).collection('userentry');

 QuerySnapshot querySnapshot=await collectionReference.get();
 return querySnapshot;

    notifyListeners();
  }



}
