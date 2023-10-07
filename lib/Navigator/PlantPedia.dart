import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Services/ChatGPTui.dart';
import 'PlantOfTheDay.dart';

class PlantPedia extends StatefulWidget {
  const PlantPedia({super.key});

  @override
  State<PlantPedia> createState() => _PlantPediaState();
}

class _PlantPediaState extends State<PlantPedia> {

  var searchCtrl = TextEditingController();

  var arrImages = [
    "assets/images/plant2_png.png",
    "assets/images/plant3_png.png",
    "assets/images/plant_png.png",
    "assets/images/plant4_png.png",
    "assets/images/plant5_png.png",
    "assets/images/plant6_png.png",
    "assets/images/plant2_png.png",
    "assets/images/plant3_png.png",
    "assets/images/plant_png.png",
    "assets/images/plant4_png.png",
  ];
  var arrPlantNames = [
    "Rasna",
    "Arive Dantu",
    "Jackfruit",
    "Basale",
    "Indian Mustard",
    "Karanda",
    "Rama",
    "Ashwagandha",
    "Cumin",
    "Neem",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFececec),
          leading: BackButton(
              color: Colors.black
          ),
          elevation: 0,
          title: Text(
            "Plant-o-Pedia",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatGPTui()));
              },
              icon: SvgPicture.asset('assets/icons/chatgpt2.svg', height: 30, color: Colors.black,),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              color: Color(0xFFececec),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        width: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color(0xffFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.11),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: InkWell(
                                  onTap: (){

                                    // if (searchCtrl.text.replaceAll(" ", "") != ""){
                                    //
                                    //   Navigator.pushReplacementNamed(context, '/loading', arguments: {
                                    //     "searchData" : searchCtrl.text.toString()
                                    //   });
                                    // }

                                  },
                                  child: Icon(CupertinoIcons.search)),
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchCtrl,
                                decoration: InputDecoration(
                                  hintText: "Search Plant name...",
                                  border: InputBorder.none,
                                ),
                                onChanged: (value){
                                  setState(() {

                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(onPressed: (){


                        }, child: SvgPicture.asset('assets/icons/filter.svg', height: 40, color: Colors.black,),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Change the border radius
                            ),
                          ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 35,),

                  Container(
                      // width: 130,
                      child: Text("Found", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 30, height: 1.2),)
                  ),
                  Container(
                      // width: 130,
                      child: Text("${arrPlantNames.length} Results", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 30, height: 1.2),)
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: GridView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        if (searchCtrl.text.isEmpty){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PlantOfTheDay(plantName: arrPlantNames[index].toLowerCase(),)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.08),
                                    spreadRadius: 7,
                                    blurRadius: 7,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(onPressed: (){

                                      }, icon: SvgPicture.asset('assets/icons/share.svg', height: 27, color: Colors.black,),),
                                      IconButton(onPressed: (){

                                      }, icon: Icon(CupertinoIcons.suit_heart_fill)),
                                    ],
                                  ),

                                  Container(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(arrImages[index]),
                                        Text(arrPlantNames[index], style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else if (arrPlantNames[index].toLowerCase().startsWith(searchCtrl.text.toLowerCase())){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PlantOfTheDay(plantName: arrPlantNames[index].toLowerCase(),)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.08),
                                    spreadRadius: 7,
                                    blurRadius: 7,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(onPressed: (){

                                      }, icon: SvgPicture.asset('assets/icons/share.svg', height: 27, color: Colors.black,),),
                                      IconButton(onPressed: (){

                                      }, icon: Icon(CupertinoIcons.suit_heart_fill)),
                                    ],
                                  ),

                                  Container(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(arrImages[index]),
                                        Text(arrPlantNames[index], style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 30, crossAxisSpacing: 30, childAspectRatio: (100/175),),
                      itemCount: arrImages.length,),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}