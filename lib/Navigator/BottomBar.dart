import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'PlantOfTheDay.dart';
import 'PlantPedia.dart';
import 'ScannerPage.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  GlobalKey key = GlobalKey();
  int _selectedIndex = 1;


  List<Widget> listPages = [
    PlantPedia(),
    ScannerPage(),
    PlantOfTheDay(plantName: "Rama".toLowerCase()),
  ];

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      body: listPages[_selectedIndex],
      bottomNavigationBar: Container(
        child: CurvedNavigationBar(
            key: key,
            backgroundColor: Colors.transparent,
            color: Color(0xff205149),
            index: _selectedIndex,
            height: screenHeight*.08,
            items: [
              SvgPicture.asset('assets/icons/plantpedia.svg', height: screenHeight*.045, color: Colors.white,),
              SvgPicture.asset('assets/icons/scanner.svg', height: screenHeight*.045, color: Colors.white,),
              FaIcon(FontAwesomeIcons.leaf,
                size: screenHeight*.045,
                color: Colors.white, ),
            ],
            onTap: (pageIndex) {
              setState(() {
                _selectedIndex = pageIndex;
              });
            }),
      ),
    );
  }
}
