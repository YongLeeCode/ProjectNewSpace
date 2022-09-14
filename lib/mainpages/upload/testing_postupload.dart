import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

class TestPostUpload extends StatefulWidget {
  const TestPostUpload({Key? key}) : super(key: key);

  @override
  State<TestPostUpload> createState() => _TestPostUploadState();
}

class _TestPostUploadState extends State<TestPostUpload> {
  final textController = TextEditingController();
  CollectionReference post = FirebaseFirestore.instance.collection('test');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textController,
        )
      ),
      body: Center(
        child: StreamBuilder(
          stream: post.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            return ListView(
              children: snapshot.data!.docs.map((post){
                return Center(
                  child: ListTile(
                    title: Text(post['color'])
                  )
                );
              },
            ).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: (){
          post.add({
            'color': textController.text
          });
        },
      ),
    );
  }
}
