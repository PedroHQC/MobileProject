import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileproject/custom-widgets/HomePage.dart';
import 'package:mobileproject/custom-widgets/ProfilePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Apenas modo retrato normal
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobileProject',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MainApp(title: 'Home'),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.title});

  final String title;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  bool _isMicActive = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isMicActive = false;
      print(index);
    });
  }

  void _toggleMic() {
    setState(() {
      _isMicActive = !_isMicActive;
    });
  }

  final List<Widget> _pageOptions = [
    HomePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMicActive = false; // Fecha o botão quando tocar fora
        });
      },
      child: Scaffold(
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
                      onPressed: () {},
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
                        padding: EdgeInsets
                            .zero, // Remove o padding interno do botão
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: _pageOptions[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined,
                    color:
                        _selectedIndex == 0 ? Color(0xFFA183D1) : Colors.grey),
                onPressed: () => _onItemTapped(0),
              ),
              SizedBox(width: 40), // Espaço para o botão flutuante
              IconButton(
                icon: Icon(Icons.person_2_outlined,
                    color:
                        _selectedIndex == 1 ? Color(0xFFA183D1) : Colors.grey),
                onPressed: () => _onItemTapped(1),
              ),
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            _toggleMic();
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: _isMicActive ? 70.0 : 56.0,
            height: _isMicActive ? 70.0 : 56.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: _isMicActive ? 10.0 : 6.0,
                  spreadRadius: _isMicActive ? 2.0 : 0.0,
                ),
              ],
            ),
            child: Icon(Icons.mic,
                color: _isMicActive ? Colors.red : Color(0xFFA183D1),
                size: _isMicActive ? 32.0 : 24.0),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
