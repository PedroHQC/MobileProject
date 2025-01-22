import 'package:flutter/material.dart';

class ClimateCard extends StatefulWidget {
  const ClimateCard({super.key});

  @override
  State<ClimateCard> createState() => _ClimateCardState();
}

class _ClimateCardState extends State<ClimateCard> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 330,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF7A9AE6),
            Color(0xFFA183D1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Location",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "New Delhi",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.ac_unit_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      "Partly Cloudy",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "8°",
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Max: 16°",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Min: 5°",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
