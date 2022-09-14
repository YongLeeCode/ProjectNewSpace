import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

class TestHome2 extends StatefulWidget {
  const TestHome2({Key? key}) : super(key: key);

  @override
  State<TestHome2> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome2> {
  int num = 0;
  List imagelist = [];
  final controller = PageController(viewportFraction: 1, keepPage: true);
  CollectionReference home = FirebaseFirestore.instance.collection('home');

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(10,
            (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300,
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Container(
            height: 280,
            child: StreamBuilder(
              stream: home.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                return ListView(
                  children: snapshot.data!.docs.map((home){
                    return Center(
                        child: Image.network(home['img'], fit: BoxFit.cover,)
                    );
                  },
                  ).toList(),
                );
              },
          ),
        )
            )
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 1,
              color: Colors.black,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2018/07/09/17/44/baby-elephant-3526681__340.png'),
                          ),
                          SizedBox(width: 5, height: 10,),
                          StreamBuilder(
                            stream: home.snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                              return Center(
                                child: Text(snapshot.data!.docs.map((home){
                                  return home['name'];
                                },).toString(),style: TextStyle(fontSize: 20),),
                              );
                            },
                          ),
                        ]
                    ),

                    Icon(Icons.subject)
                  ],
                )
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                color: Colors.white70,
                child: StreamBuilder(
                  stream: home.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                    return Container(
                      child: Text(snapshot.data!.docs.map((home){
                        return home['story'];
                      },).toString(),style: TextStyle(fontSize: 20),),
                    );
                  },
                ),
            ),

            Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 16),
                      SizedBox(
                        height: 240,
                        child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              PageView.builder(
                                controller: controller,
                                itemCount: pages.length,
                                itemBuilder: (_, index) {
                                  return pages[index % pages.length];
                                },
                                onPageChanged: (x){
                                  setState(() {
                                    num = x;
                                  });
                                },
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(500)
                                ),
                                child: Text('${num+1}/${pages.length}'),
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              color: Colors.white70,
              child: Row(
                children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2018/07/09/17/44/baby-elephant-3526681__340.png'),
                      ),
                      SizedBox(width: 10,),
                      StreamBuilder(
                        stream: home.snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                          return Center(
                            child: Column(
                              children: [

                                Text(snapshot.data!.docs.map((home){
                                  return home['reply'];
                                },).toString(),style: TextStyle(fontSize: 20),),
                              ]
                            ),
                          );
                        },
                      ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
