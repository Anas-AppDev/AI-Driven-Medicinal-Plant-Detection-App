import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: videoPage(),
  ));
}

class videoPage extends StatefulWidget {
  const videoPage({super.key});

  @override
  State<videoPage> createState() => _videoPageState();
}

class _videoPageState extends State<videoPage> {

  File? imgFile;

  var downloadUrl;

  Future<void> uploadVideoToFirebaseStorage(File file) async {
    try {
      var fstorage = FirebaseStorage.instance;
      Reference storageReference = fstorage.ref().child('Plantpedia/${DateTime.now()}.jpg');

      UploadTask uploadTask = storageReference.putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // plantApi(downloadUrl);
      print("Video uploaded. Download URL: $downloadUrl");

    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void getVideo({required ImageSource source}) async{
    var pickedImg = await ImagePicker().pickVideo(source: source, maxDuration: Duration(seconds: 15));

    if (pickedImg != null){
      setState(() {
        imgFile = File(pickedImg.path);
      });

      print("imgFile :"+imgFile.toString());
      await uploadVideoToFirebaseStorage(imgFile!);
    }
    else{
      print("Pick an video");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Video from gallery"),
              onPressed: (){
                getVideo(source: ImageSource.gallery);
              },
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              child: Text("Video from camera"),
              onPressed: (){
                getVideo(source: ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
