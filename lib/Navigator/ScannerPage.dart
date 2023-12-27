import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

import 'PlantOfTheDay.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  File? imgFile;
  String downloadUrl = "https://encrypted-tbn2.gstatic.com/licensed-image?q=tbn:ANd9GcS16qErG-bEEmeYvwdyN92svVxmTZiRDDGb6mjtFgeiLxUELR25jb47dtPybI20uGs18Sji1jH-D9Y1eso";

  var prediction = "Scan";

  Future<void> uploadImageToFirebaseStorage(File file) async {
    try {
      var fstorage = FirebaseStorage.instance;
      Reference storageReference = fstorage.ref().child('Plantpedia/${DateTime.now()}.jpg');

      UploadTask uploadTask = storageReference.putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      downloadUrl = await taskSnapshot.ref.getDownloadURL();

      plantApi(downloadUrl);

      print("Image uploaded. Download URL: $downloadUrl");

    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void getImage({required ImageSource source}) async{
    var pickedImg = await ImagePicker().pickImage(source: source);

    if (pickedImg != null){
      setState(() {
        imgFile = File(pickedImg.path);
        // print("PickedImg : " + pickedImg.path);
      });

      await uploadImageToFirebaseStorage(imgFile!);
    }
    else{
      print("Pick an image");
    }
  }

  void plantApi(String downloadUrl) async {
    var Apiurl = "http://127.0.0.1:8000/model";
    var data = {
      "image": downloadUrl,
    };
    var body = json.encode(data);
    var urlParse = Uri.parse(Apiurl);

    try {
      http.Response response = await http.post(
        urlParse,
        body: json.decode(body),

      );

      if (response.statusCode == 200) {
        var printData = jsonDecode(response.body);
        setState(() {
          prediction = printData['prediction'][0];
        });
        print(printData['prediction'][0]);
      } else {
        setState(() {
          prediction = "Not Found";
        });
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      setState(() {
        prediction = "Not Found";
      });
      print("Error: $error");
    }
  }

  @override
  void initState() {
    getImage(source: ImageSource.camera);
    super.initState();
    // setState(() {
    //   plantApi();
    // });
  }

  @override
  Widget build(BuildContext context) {

    var devicePixel = MediaQuery.of(context).devicePixelRatio;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      body : Stack(
        children: [
          (imgFile != null) ? Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(imgFile!),
                fit: BoxFit.cover,
              ),
            ),
          ) : Container(child: Image.asset("assets/images/scannerBg.png", width: double.infinity, height: double.infinity, fit: BoxFit.fill,),),


          Column(
            children: [
              SizedBox(height: screenHeight*.08,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(width: screenWidth*.08,),
                    SvgPicture.asset('assets/icons/flash.svg', height: devicePixel*7, color: Colors.white,),
                    // SizedBox(width: screenWidth*.216,),
                    Text("   Plant o Pedia", style: TextStyle(color: Colors.white, fontSize: devicePixel*6.8, fontWeight: FontWeight.bold, fontFamily: "Poppins")),
                    // SizedBox(width: screenWidth*.19,),
                    Icon(Icons.more_vert, color: Colors.white, size: devicePixel*11,),
                  ],
                ),
              ),

              SizedBox(height: screenHeight*.67,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      getImage(source: ImageSource.gallery);
                    },
                    child: Container(
                      height: screenHeight*.06,
                      width: screenWidth*.13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Transform.scale(child: SvgPicture.asset('assets/icons/img.svg', color: Colors.black,), scale: screenHeight*.001,),
                    ),
                  ),
                  SizedBox(width: screenWidth*.03,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: PlantOfTheDay(plantName: prediction.toLowerCase(),)));
                    },
                    child: Container(
                      height: screenHeight*.07,
                      width: screenWidth*.54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(prediction.toUpperCase(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: devicePixel*5),),
                          SizedBox(width: screenWidth*.03,),
                          Icon(CupertinoIcons.arrow_up_circle_fill, color: Colors.black, size: devicePixel*7,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth*.03,),
                  InkWell(
                    onTap: (){
                      getImage(source: ImageSource.camera);
                    },
                    child: Container(
                      height: screenHeight*.06,
                      width: screenWidth*.13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Transform.scale(child: SvgPicture.asset('assets/icons/camera.svg', color: Colors.black,), scale: screenHeight*.001,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
