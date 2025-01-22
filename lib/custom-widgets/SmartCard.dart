import 'package:flutter/material.dart';

class Smartcard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const Smartcard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  State<Smartcard> createState() => _SmartcardState();
}

class _SmartcardState extends State<Smartcard> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 234,
      width: 155,
      child: Column(
        children: [
          Container(
            height: 234 / 2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20,
                  spreadRadius: 0.01,
                  offset: Offset(5, 5),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              image: DecorationImage(
                image: AssetImage(widget.imagePath),
                alignment: Alignment(0, -1),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            height: 234 / 2,
            width: 155,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20,
                  spreadRadius: 0.01,
                  offset: Offset(5, 5),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.subtitle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        isOn ? "ON" : "OFF",
                        style: TextStyle(fontSize: 24),
                      ),
                      Switch(
                        value: isOn,
                        onChanged: (value) {
                          setState(() {
                            isOn = value;
                          });
                        },
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
