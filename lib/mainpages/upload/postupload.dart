import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_space2/mainpages/home.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

class PostUpload extends StatefulWidget {
  const PostUpload({Key? key}) : super(key: key);

  @override
  State<PostUpload> createState() => _PostUploadState();
}

class _PostUploadState extends State<PostUpload> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("home").snapshots(),
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
                  largeTitle: Text("Post"),
                ),
                SliverList(delegate: SliverChildListDelegate(
                  snapshot.data!.docs.map((DocumentSnapshot document){
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return Container(
                      child: Column(
                        children: [
                          Text(data['text']),
                          Image.network(data['img']),
                        ],
                      ) ,

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
      )

    );
  }
}
