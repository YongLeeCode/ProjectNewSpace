import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class PostCard extends StatefulWidget {

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int currentPageIndex = 0;

  final controller = PageController(viewportFraction: 1, keepPage: true);

  List<String> imageList = [
    'https://mblogthumb-phinf.pstatic.net/MjAxODA5MDVfNDQg/MDAxNTM2MDk4MTcyMDQ5.Y0_CqPuYLKzdcX5tz1RGLkfJXh6_4RA3WTVMsq5d2R0g.OzL_BqH-wdaj41U7u_QBYJZqrTTnuX_aLEq_IWVIaxMg.JPEG.nydelphie/%EC%8A%A4%ED%86%A0%EB%A6%AC_%285%29.jpg?type=w800',
    'https://i.ytimg.com/vi/xRbPAVnqtcs/maxresdefault.jpg',
    'https://d1blyo8czty997.cloudfront.net/cms-images/setting/800x640/5061381120.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGUcTbH6PHnltnE41JGM90r4kiOc0sWCYj4w&usqp=CAU',
  ];
  
  List<String> textList = [
    "재밌었어요! 또 가고 싶어요.",
    "2022 가족과 함께 떠나는 여행",
    "라스베가스 여행!",
    "즐거웠던 여행 사진들 공유"
  ];

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
            child: Center(
                child: Image.network(imageList[Random().nextInt(4)], fit: BoxFit.cover,)
            ),
          ),
        )
    );

    return Container(
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
                    Text("Yonghwan", style:
                      TextStyle(
                        fontSize: 20,
                      ),
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
            child: Text(textList[Random().nextInt(4)],
                style: TextStyle(fontSize: 20,))
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
                                currentPageIndex = x;
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
                            child: Text('${currentPageIndex+1}/${pages.length}'),
                          )
                        ]
                      ),
                    ),
                  ],
                ),
              )
          ),

          Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            color: Colors.white38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite),
                    SizedBox(width: 5,),
                    Icon(Icons.reply),
                    SizedBox(width: 5,),
                  ],
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    type: WormType.thin,
                    activeDotColor: Colors.greenAccent
                  ),
                ),
                Icon(Icons.bookmark_border)
              ],
            ),

          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            color: Colors.white70,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2018/07/09/17/44/baby-elephant-3526681__340.png'),
                    ),
                    Text("Yonghwan",style: TextStyle(fontSize: 20,)),
                    SizedBox(width: 10,),
                    Text("제목을 적어주세요",style: TextStyle(fontSize: 20,)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
