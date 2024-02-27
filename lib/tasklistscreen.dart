import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_app/Homescreen.dart';
import 'package:firebase_firestore_app/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('task screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: context.read<SignUpProvider>().showTaskOnScreen(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List tasklist = snapshot.data!.docs;
//for list
            if (tasklist.isEmpty) {
              return Text('No task');
            }

            return ListView.builder(
              itemCount: tasklist.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tasklist[index]['title']),
                    subtitle: Text(tasklist[index]['description']),
                  ),
                );
              },
            );
          }

          //second
          else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: SpinKitDualRing(color: Colors.purple));
          }
          //third

          // !snapshot.hasData: Checks if there is no data available in the stream. If snapshot.hasData is false, it means no new data has been received yet.
          //
          //     snapshot.data!.docs.isEmpty: Once there is data in the stream, this checks if the documents list (docs) in the retrieved data is empty. If it's empty, there are no documents in the collection.
          //
          //     So, the entire condition !snapshot.hasData || snapshot.data!.docs.isEmpty is saying: "If there is no data in the stream or if there is data but it contains no documents (empty documents list), then do something."
          //
        },
      ),
    );
  }
}
