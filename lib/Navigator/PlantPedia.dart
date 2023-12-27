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

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

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
              icon: SvgPicture.asset('assets/icons/chatgpt2.svg', height: screenHeight*.043, color: Colors.black,),
            ),
          ],
        ),
        body: Container(
          color: Color(0xFFececec),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: screenHeight*.03,),
                Row(
                  children: [
                    Container(
                      width: screenWidth*.68,
                      height: screenHeight*.057,
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
                                child: Icon(CupertinoIcons.search, size: screenWidth*.06,)),
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
                    SizedBox(width: screenWidth*.03,),
                    Container(
                      height: screenHeight*.057,
                      width: screenWidth*.123,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.11),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(onPressed: (){


                      }, child: SvgPicture.asset('assets/icons/filter.svg', height: screenWidth*.6, color: Colors.black,),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Change the border radius
                            ),
                            shadowColor: Colors.transparent
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*.07,),

                Container(
                  // width: 130,
                    child: Text("Found", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: screenWidth*.085, height: 1.2),)
                ),
                Container(
                  // width: 130,
                    child: Text("${arrPlantNames.length} Results", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: screenWidth*.085, height: 1.2),)
                ),
                SizedBox(height: screenHeight*.02,),
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

                                    }, icon: SvgPicture.asset('assets/icons/share.svg', height: screenHeight*.026, color: Colors.black,),),
                                    IconButton(onPressed: (){

                                    }, icon: Icon(CupertinoIcons.suit_heart_fill, size: screenHeight*.026,)),
                                  ],
                                ),

                                Container(
                                  height: screenHeight*.24,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(arrImages[index], height: screenHeight*.2, width: screenWidth*.5,),
                                      Text(arrPlantNames[index], style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: screenWidth*.043),),
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

                                    }, icon: SvgPicture.asset('assets/icons/share.svg', height: screenHeight*.026, color: Colors.black,),),
                                    IconButton(onPressed: (){

                                    }, icon: Icon(CupertinoIcons.suit_heart_fill, size: screenHeight*.026,)),
                                  ],
                                ),

                                Container(
                                  height: screenHeight*.24,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(arrImages[index], height: screenHeight*.2, width: screenWidth*.5,),
                                      Text(arrPlantNames[index], style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: screenWidth*.043),),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                        );
                      }

                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: screenWidth*.06, crossAxisSpacing: screenWidth*.06, childAspectRatio: screenWidth*.00148,),
                    itemCount: arrImages.length,),
                ),
              ],
            ),
          ),
        )
    );
  }
}