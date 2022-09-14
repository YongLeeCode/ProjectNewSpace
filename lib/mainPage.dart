import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_space2/mainpages/addPerson.dart';
import 'package:new_space2/mainpages/addPhoto.dart';
import 'package:new_space2/mainpages/testhome2.dart';
import 'package:new_space2/mainpages/upload/testing_postupload.dart';

import 'mainpages/alarm.dart';
import 'mainpages/home.dart';
import 'mainpages/myAlbum.dart';
import 'package:new_space2/post/post.dart';

import 'mainpages/upload/imgupload.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // 메인 페이지
  List pages=[
    Home(),
    MyAlbum(),
    TestHome2(),
    Alarm(),
    AddPerson(),
  ];

  // 하단 네비게이션 바
  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'myAlbum'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'test'),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: 'alarm',),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_add),
        label: 'person'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Family Album", style: TextStyle(fontFamily: 'DynaPuff_bold', fontSize: 40, color: Colors.white70),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white24,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.blueGrey,
        selectedFontSize: 14,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: navigationItems,
      ),
    );
  }
}
