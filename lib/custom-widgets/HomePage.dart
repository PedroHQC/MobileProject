import 'package:flutter/material.dart';
import 'package:mobileproject/custom-widgets/ClimateCard.dart';
import 'package:mobileproject/custom-widgets/NavToggles.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClimateCard(),
            NavToggles(),
          ],
        ),
      ),
    );
  }
}