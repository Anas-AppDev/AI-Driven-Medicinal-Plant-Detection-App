import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: dataFeed(),
  ));
}

class dataFeed extends StatefulWidget {
  const dataFeed({super.key});

  @override
  State<dataFeed> createState() => _dataFeedState();
}

class _dataFeedState extends State<dataFeed> {

  var plantName = TextEditingController();
  var humidity = TextEditingController();
  var temp = TextEditingController();
  var family = TextEditingController();
  var sciName = TextEditingController();
  var otherName = TextEditingController();
  var about = TextEditingController();
  var prop = TextEditingController();
  var safety = TextEditingController();
  var prep = TextEditingController();
  var habitat = TextEditingController();
  var references = TextEditingController();

  var firestore = FirebaseFirestore.instance.collection("PlantPedia");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: plantName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Plant Name",
              ),
              maxLines: 1,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: humidity,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Humidity",
              ),
              maxLines: 1,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: temp,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "temp",
              ),
              maxLines: 1,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: family,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Family",
              ),
              maxLines: 1,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: sciName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "scientific name",
              ),
              maxLines: 1,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: otherName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "other name",
              ),
              maxLines: 1,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: about,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "About",
              ),
              maxLines: 4,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: prop,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Properties",
              ),
              maxLines: 4,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: safety,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "safety",
              ),
              maxLines: 4,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: prep,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "preparation",
              ),
              maxLines: 4,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: habitat,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "habitat",
              ),
              maxLines: 4,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: references,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "references",
              ),
              maxLines: 2,
              validator: (value){
                if (value!.isEmpty){
                  return "Item Name is required";
                }
                return null;
              },
            ),
            ElevatedButton(onPressed: (){

              firestore.doc("Plants").collection(plantName.text.toLowerCase()).add(
                  {

                    "humidity": humidity.text,
                    "temp": temp.text,
                    "family": family.text,
                    "sciName": sciName.text,
                    "otherName": otherName.text,
                    "about": about.text,
                    "prop": prop.text,
                    "safety": safety.text,
                    "prep": prep.text,
                    "habitat": habitat.text,
                    "references": references.text,

                  }
              );

              print(plantName.text.toString());

            }, child: Text("submit")),
          ],
        ),
      ),
    );
  }
}
