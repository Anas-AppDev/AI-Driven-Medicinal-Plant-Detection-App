import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlantOfTheDay extends StatefulWidget {

  String plantName;
  PlantOfTheDay({
    super.key,
    required this.plantName,
  });

  @override
  State<PlantOfTheDay> createState() => _PlantOfTheDayState();
}

class _PlantOfTheDayState extends State<PlantOfTheDay> {

  var firestore = FirebaseFirestore.instance.collection("PlantPedia");

  @override
  Widget build(BuildContext context) {
    // print(snapshot['plant Name']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFececec),
        leading: BackButton(
            color: Colors.black
        ),
        elevation: 0,
        title: Text(
          "Plant of the Day",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(CupertinoIcons.heart, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/share.svg', height: 27, color: Colors.black,),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFFececec),
          ),

          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 30,),
              child: StreamBuilder(
                stream: firestore.doc("Plants").collection(widget.plantName).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasError){
                    return Center(child: Text("Something went wrong"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CupertinoActivityIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty){
                    return Center(child: Text("No data found"));
                  }


                  if (snapshot!=null && snapshot.data!=null){
                    var humidity = snapshot.data!.docs[0]['humidity'];
                    var temp = snapshot.data!.docs[0]['temp'];
                    var family = snapshot.data!.docs[0]['family'];
                    var sciName = snapshot.data!.docs[0]['sciName'];
                    var otherName = snapshot.data!.docs[0]['otherName'];
                    var about = snapshot.data!.docs[0]['about'];
                    var prop = snapshot.data!.docs[0]['prop'];
                    var safety = snapshot.data!.docs[0]['safety'];
                    var prep = snapshot.data!.docs[0]['prep'];
                    var habitat = snapshot.data!.docs[0]['habitat'];
                    var references = snapshot.data!.docs[0]['references'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40,),
                        Container(
                            width: 280,
                            child: Text(toSentenceCase(widget.plantName), style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 30, height: 1.2),)
                        ),
                        // SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 80,),
                                Container(height: 85, width: 90, decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(CupertinoIcons.drop_fill, color: Color(0xff205149)),SizedBox(height: 5,), Text(humidity, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff205149)),)],) ,),
                                SizedBox(height: 30,),
                                Container(height: 85, width: 90, decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(CupertinoIcons.thermometer, color: Color(0xff205149), size: 30,),SizedBox(height: 5,), Text(temp, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff205149)),)],) ,),

                                SizedBox(height: 50,),
                                Text("Family", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 20),),
                                Container(
                                  width: 88,
                                    child: Text(family, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),)),
                              ],
                            ),

                            SizedBox(width: 50,),
                            Container(
                                height: 390,
                                width: 220,
                                child: Image.asset("assets/images/plant_png.png",fit: BoxFit.cover, alignment: Alignment.topLeft,)),
                          ],
                        ),

                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 40,),
                                Text("Scientific Name", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 20),),
                                Container(
                                  width: 160,
                                    child: Text(sciName, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),)),

                              ],
                            ),
                            SizedBox(width: 50,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 40,),
                                Text("Other Name", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 20),),
                                Container(
                                  width: 140,
                                    child: Text(otherName, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),)),

                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 50,),
                        Text("About", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 25),),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text(about, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),),
                        ),


                        SizedBox(height: 50,),
                        Text("Properties", textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 20),),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text(prop, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),),
                        ),


                        SizedBox(height: 50,),
                        Text("Safety & Precautions", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 20),),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text(safety, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),),
                        ),


                        SizedBox(height: 50,),
                        Text("Preparation & Dosage", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 20),),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text(prep, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),),
                        ),


                        SizedBox(height: 50,),
                        Text("Habitat & Availability", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 20),),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text(habitat, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),),
                        ),


                        SizedBox(height: 50,),
                        Text("References", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins",fontSize: 20),),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text(references, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Poppins",fontSize: 14, color: Color(0xff818181)),),
                        ),
                        SizedBox(height: 50,),
                      ],
                    );
                  }

                  // print(snapshot.data!.docs[0]['b']);
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  String toSentenceCase(String input) {
    if (input == null || input.isEmpty) {
      return "";
    }

    // Split the input string into sentences using '.' as the delimiter.
    List<String> sentences = input.split('. ');

    // Capitalize the first letter of each sentence.
    for (int i = 0; i < sentences.length; i++) {
      sentences[i] = sentences[i][0].toUpperCase() + sentences[i].substring(1).toLowerCase();
    }

    // Join the sentences back together with '. ' to form the sentence case string.
    return sentences.join('. ');
  }
}
