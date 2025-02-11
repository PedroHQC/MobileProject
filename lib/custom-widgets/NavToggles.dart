import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileproject/custom-widgets/SmartCard.dart';

class NavToggles extends StatefulWidget {
  const NavToggles({super.key});

  @override
  State<NavToggles> createState() => _NavTogglesState();
}

class _NavTogglesState extends State<NavToggles> {
  final List<bool> _isSelected = [true, false];
  int _activeTabIndex = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> rooms = [];
  List<Map<String, dynamic>> devices = [];

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  // Função para buscar os dados do usuário logado
  Future<void> _fetchCards() async {
    final user = _auth.currentUser;
    if (user == null) {
      print("Usuário não autenticado!");
      return;
    }

    try {
      String? token = await user.getIdToken();
      if (token == null) {
        print("Falha ao obter token de autenticação.");
        return;
      }

      QuerySnapshot roomSnapshot = await _firestore
          .collection('rooms')
          .where('userId', isEqualTo: user.uid)
          .get();

      QuerySnapshot deviceSnapshot = await _firestore
          .collection('devices')
          .where('userId', isEqualTo: user.uid)
          .get();

      setState(() {
        rooms = roomSnapshot.docs
            .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
            .toList();
        devices = deviceSnapshot.docs
            .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
            .toList();
      });
    } catch (e) {
      print("Erro ao buscar os dados: $e");
    }
  }

  // Função para adicionar um novo card ao Firestore
  Future<void> _addCard(String type) async {
    final user = _auth.currentUser;
    if (user == null) {
      print("Usuário não autenticado!");
      return;
    }

    try {
      String? token = await user.getIdToken();
      if (token == null) {
        print("Falha ao obter token de autenticação.");
        return;
      }

      Map<String, dynamic> newCard = {
        "title": type == "room" ? "New Room" : "New Device",
        "subtitle": "0 Devices",
        "imagePath": type == "room"
            ? "lib/assets/quarto.png"
            : "lib/assets/aaaipad.png",
        "userId": user.uid,
        "createdAt": FieldValue.serverTimestamp(),
      };

      DocumentReference docRef = await _firestore
          .collection(type == "room" ? "rooms" : "devices")
          .add(newCard);

      setState(() {
        if (type == "room") {
          rooms.add({"id": docRef.id, ...newCard});
        } else {
          devices.add({"id": docRef.id, ...newCard});
        }
      });
    } catch (e) {
      print("Erro ao adicionar card: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(12),
              isSelected: _isSelected,
              fillColor: Colors.white,
              selectedColor: Colors.black,
              color: Colors.grey,
              borderColor: Colors.grey.shade300,
              selectedBorderColor: Colors.black,
              constraints: const BoxConstraints(
                minWidth: 150,
                minHeight: 35,
              ),
              onPressed: (index) {
                setState(() {
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = i == index;
                  }
                  _activeTabIndex = index;
                });
              },
              children: const [
                Text('Room'),
                Text('Devices'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (widget, animation) => FadeTransition(
              opacity: animation,
              child: widget,
            ),
            child: Padding(
              key: ValueKey<int>(_activeTabIndex),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 20,
                runSpacing: 20,
                children: [
                  ...(_activeTabIndex == 0 ? rooms : devices).map((data) => Smartcard(
                        imagePath: data['imagePath'],
                        title: data['title'],
                        subtitle: data['subtitle'],
                        type: _activeTabIndex == 0 ? "room" : "device",
                      )),
                  GestureDetector(
                    onTap: () => _addCard(_activeTabIndex == 0 ? "room" : "device"),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add, size: 50, color: Colors.black),
                    ),
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
