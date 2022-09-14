import 'package:flutter/material.dart';
import 'package:new_space2/cards/postCard.dart';
import 'package:new_space2/mainpages/upload/postupload.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index){
                return PostCard();
              },
              separatorBuilder: (BuildContext context, int index){
                return SizedBox(height: 20,);
              },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostUpload())
          );
        },
      ),
    );
  }
}
