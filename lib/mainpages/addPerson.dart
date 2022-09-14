import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddPerson extends StatefulWidget {
  const AddPerson({Key? key}) : super(key: key);

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  void callChatScreen(String name, String uid) {

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .where('uid', isNotEqualTo: currentUser)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
        if(snapshot.hasError){
          return Center(child: Text("something has a problem."),);
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: Text("Loading"),);
        }
        if(snapshot.hasData){
          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text("people"),
              ),
              SliverList(delegate: SliverChildListDelegate(
                  snapshot.data!.docs.map((DocumentSnapshot document){
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return ListTile(
                      onTap: ()=> callChatScreen(data['name'], data['uid']),
                      title: Text('name'),
                      subtitle: Text('uid'),
                    );
                  }).toList()
              ))
            ],
          );
        }
        else {
          return Center(child: Text("something has a problem."),);
        }
      },
    );
  }
}