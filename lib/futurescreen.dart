import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_app/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'Homescreen.dart';

class FutureBuilderScreen extends StatefulWidget {
  const FutureBuilderScreen({super.key});

  @override
  State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('futurescreen'),
        actions: [

          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ));
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.black,
              ))


        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: context.read<SignUpProvider>().showTaskOnScreenFuture(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List list = snapshot.data!.docs;

              if (list.isEmpty) {
                return Text('No task');
              }

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(list[index]['title']),
                      subtitle: Text(list[index]['title']),
                    ),
                  );
                },
              );



            }else if(snapshot.hasError){
              return const Center(child: Text('Something went wrong'));

            }else {


               return const Center(child: SpinKitDualRing(color: Colors.purple));
            }
          }),
    );
  }
}
