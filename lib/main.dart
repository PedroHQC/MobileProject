import 'package:flutter/material.dart';
import 'package:mobileproject/custom-widgets/NavToggles.dart';
import 'package:mobileproject/custom-widgets/ClimateCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Home",
                    style: TextStyle(fontSize: 22),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.black,
                    onPressed: () {
                      print("Clicked");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Family Members",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 24, // Altura do botão
                    width: 24, // Largura do botão
                    child: IconButton(
                      icon: Image.asset(
                        'lib/assets/personIcon.png',
                        width:
                            16, // Tamanho da imagem ajustado para caber no botão
                        height: 16,
                      ),
                      padding:
                          EdgeInsets.zero, // Remove o padding interno do botão
                      onPressed: () {
                        print("Person icon clicked!");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
