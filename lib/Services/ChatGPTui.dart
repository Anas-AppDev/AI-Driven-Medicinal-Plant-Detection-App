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
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(color: Color(0xffececec),),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Container(
                      width: 280,
                      child: Text("Plant GPT", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 30, height: 1.2),)
                  ),
                  SizedBox(height: 40,),
                  response=="" ? Container(
                    height: 460,
                    child: Lottie.asset("assets/lottie/plant.json",height: 400, width: 400 ,repeat: true),) : Container(height: 460, child: Text(response),),
                  Column(
                    children: [
                      SizedBox(height: 40,),
                      Container(

                        child: Row(
                          children: [
                            Container(
                              width: 280,
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
                                  SizedBox(width: 10,),
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
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: (){
                                sendMessage();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: SvgPicture.asset('assets/icons/send.svg', height: 50, color: Colors.black,),
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