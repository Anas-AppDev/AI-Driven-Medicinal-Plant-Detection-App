import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'OpenAIAPI.dart';

class ChatGPTui extends StatefulWidget {
  @override
  _ChatGPTuiState createState() => _ChatGPTuiState();
}

class _ChatGPTuiState extends State<ChatGPTui> {
  TextEditingController messageController = TextEditingController();
  String response = '';
  //sendMessage

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    String message = messageController.text;

    if (message.isNotEmpty) {
      try {
        String apiResponse = await ApiService.sendMessage(message: message);
        setState(() {
          response = apiResponse;
        });
      } catch (error) {
        setState(() {
          response = 'Error: $error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    var devicePixel = MediaQuery.of(context).devicePixelRatio;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFececec),
        leading: BackButton(
            color: Colors.black
        ),
        elevation: 0,
        title: Text(
          "know about your Roots",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            fontSize: devicePixel*6,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(color: Color(0xffececec),),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*.076),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight*.053,),
                  Container(
                      child: Text("Plant GPT", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: devicePixel*10, height: 1.2),)
                  ),
                  SizedBox(height: screenHeight*.06,),
                  response=="" ? Container(
                    height: screenHeight*.53,
                    child: Lottie.asset("assets/lottie/plant.json",height: screenHeight*.53, width: screenWidth*.9, repeat: true),) : Container(height: screenHeight*.53, child: Text(response),),
                  Column(
                    children: [
                      SizedBox(height: screenHeight*.06,),
                      Container(

                        child: Row(
                          children: [
                            Container(
                              width: screenWidth*.71,
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
                                  SizedBox(width: screenWidth*.04,),
                                  Expanded(
                                    child: TextField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        hintText: "Search something about plant...",
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
                            SizedBox(width: screenWidth*.027,),
                            InkWell(
                              onTap: (){
                                sendMessage();
                              },
                              child: Container(
                                height: screenHeight*.07,
                                width: screenWidth*.103,
                                child: SvgPicture.asset('assets/icons/send.svg', color: Colors.black,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}