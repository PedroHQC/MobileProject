import 'package:flutter/material.dart';
import 'package:mobileproject/custom-widgets/HeaterControlScreen.dart';

class Smartcard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String type; // "room" ou "device"

  const Smartcard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  @override
  State<Smartcard> createState() => _SmartcardState();
}

class _SmartcardState extends State<Smartcard> {
  bool isOn = true;

  void _navigateToHeaterControl(BuildContext context) {
    if (widget.type == "device") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HeaterControlScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToHeaterControl(context),
      child: SizedBox(
        height: 234,
        width: 155,
        child: Column(
          children: [
            // Imagem do card
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
            // Conteúdo do card
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.subtitle, style: TextStyle(color: Colors.grey[700])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            isOn ? "ON" : "OFF",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
