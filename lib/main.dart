import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobileproject/custom-widgets/HomePage.dart';
import 'package:mobileproject/custom-widgets/ProfilePage.dart';
import 'package:mobileproject/custom-widgets/LoginPage.dart';
import 'package:mobileproject/custom-widgets/SingnUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
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
      theme: ThemeData(useMaterial3: true),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}

// Verifica o estado de autenticação
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            return MainApp(title: 'Home', user: user);
          } else {
            return LoginPage();
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.title, required this.user});
  final String title;
  final User user;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  bool _isMicActive = false;

  final List<Widget> _pageOptions = [
    HomePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    fetchStatus();
  }

  void fetchStatus() {
    // Aqui você pode chamar a função que busca o status do usuário
    print("Buscando status para ${widget.user.uid}...");
    // Exemplo: Chamada para API ou Firebase Firestore
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isMicActive = false;
    });
  }

  void _toggleMic() => setState(() => _isMicActive = !_isMicActive);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isMicActive = false),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title, style: const TextStyle(fontSize: 22)),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Family Members", style: TextStyle(fontSize: 18, color: Colors.grey)),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        icon: ImageIcon(AssetImage('lib/assets/personIcon.png')),
                        onPressed: null,
                        padding: EdgeInsets.zero,
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
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined, color: _selectedIndex == 0 ? const Color(0xFFA183D1) : Colors.grey),
                onPressed: () => _onItemTapped(0),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: Icon(Icons.person_2_outlined, color: _selectedIndex == 1 ? const Color(0xFFA183D1) : Colors.grey),
                onPressed: () => _onItemTapped(1),
              ),
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: _toggleMic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
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
            child: Icon(
              Icons.mic,
              color: _isMicActive ? Colors.red : const Color(0xFFA183D1),
              size: _isMicActive ? 32.0 : 24.0,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
