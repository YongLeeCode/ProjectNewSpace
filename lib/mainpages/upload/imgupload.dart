import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImgUpload extends StatefulWidget {
  const ImgUpload({Key? key}) : super(key: key);

  @override
  State<ImgUpload> createState() => _ImgUploadState();
}

class _ImgUploadState extends State<ImgUpload> {
  FirebaseStorage storageRef = FirebaseStorage.instance;
  CollectionReference image = FirebaseFirestore.instance.collection('images');
  final ImagePicker imagePicker = ImagePicker();
  final ref = FirebaseStorage.instance.ref().child('gs://newspace2-ebaa0.appspot.com/multiple_images');
  List<XFile>? imageFileList = [];
  List<String> _arrImageUrls = [];
  int uploadItem = 0;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 500,
      width: 200,
      child: _isUploading ? showLoading() :Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: imageFileList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.file(
                          File(imageFileList![index].path),
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                ),
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: (){
                  if(imageFileList!.isNotEmpty) {
                    uploadFunction(imageFileList!);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select images."))
                    );
                  }
                },
                  child: Column(
                      children: [
                        Icon(Icons.file_upload),
                        Text("Upload files")
                      ]
                  )
              ),
              SizedBox(width: 20,),
              RaisedButton(
                onPressed: (){
                  selectImages();
                },
                  child: Column(
                      children: [
                        Icon(Icons.add),
                        Text("Bring Images")
                      ]
                  )
              ),
              SizedBox(width: 20,),
              RaisedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Icon(Icons.star),
                    Text("My Album")
                  ]
                )
              ),
            ],
          ),
          imageFileList!.length == 0
              ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Text("no images selcted",
                style: TextStyle(fontSize: 20, color: Colors.black38),),
          )
              : Text("Image selected : " + imageFileList!.length.toString(),
            style: TextStyle(fontSize: 20, color: Colors.black38),),
        ]
    ),
    );
  }

  Widget showLoading(){
    return Center(child: Column(
      children: [
        Text("uploading : " + uploadItem.toString() +  "/" + imageFileList!.length.toString(),
        style: TextStyle(fontSize: 20, color: Colors.black38),
        ),
        SizedBox(height: 20,),
        CircularProgressIndicator( )
      ],
    ),);
  }

  void uploadFunction(List<XFile> _images){
    setState(() {
      _isUploading = true;
    });
    for(int i = 0 ;  i<_images.length; i++){
      var imageUrl = uploadFile(_images[i]);
      _arrImageUrls.add(imageUrl.toString());
    }
  }

  Future<String?> uploadFile(XFile _image) async{
    Reference reference =
    storageRef.ref()
        .child("images")
        .child(_image.name);
    UploadTask uploadTask = reference.putFile(File(_image.path));
    await uploadTask.whenComplete(() async {
      setState(() {
        reference.getDownloadURL().then((value) => image.add({'url': value}));
        uploadItem++;
        if(uploadItem==imageFileList!.length){
          _isUploading = false;
          uploadItem = 0;
        }
      });
    });
    
    await reference.getDownloadURL();
  }

  void selectImages() async{
    if(imageFileList != null){
      imageFileList!.clear();
    }
    try {
      final List<XFile>? imgs = await imagePicker.pickMultiImage();
      if(imgs!.isNotEmpty){
        imageFileList!.addAll(imgs);
      }
      print("list of selected images : " + imgs.length.toString());
    }catch(e){
      print("error!!!" + e.toString());
    }
    setState(() {
    });
  }
}
