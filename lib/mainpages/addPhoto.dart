import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({Key? key}) : super(key: key);

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [
            MaterialButton(
                color: Colors.green,
                child: const Text(
                    "Post home",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                  selectImages();
                }
            ),
            MaterialButton(
                color: Colors.green,
                child: const Text(
                    "Post home",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                  selectImages();
                }
            ),
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
                        return Image.file(File(imageFileList![index].path), fit: BoxFit.cover);
                      }
                  ),
                )
            )
          ]
      ),
    );
  }

  void selectImages() async{
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if(selectedImages!.isNotEmpty){
      imageFileList!.addAll(selectedImages);
    }
    setState(() {

    });
  }
}
