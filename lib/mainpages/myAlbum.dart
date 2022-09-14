import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class MyAlbum extends StatefulWidget {
  @override
  State<MyAlbum> createState() => _MyAlbumState();
}


class _MyAlbumState extends State<MyAlbum> {
  CollectionReference photo = FirebaseFirestore.instance.collection('images');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container()
    );
  }
}


