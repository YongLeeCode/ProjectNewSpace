import 'package:flutter/material.dart';

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              // Image.network(src)
              child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/newspace2-ebaa0.appspot.com/o/multiple_images%2Fimage_picker3302310880589135060.jpg?alt=media&token=24f3b96a-9667-4cea-93de-bf13a77d6627"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  "https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            )
          ]
      ),
    );
  }
}
