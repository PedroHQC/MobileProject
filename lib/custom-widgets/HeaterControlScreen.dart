import 'package:flutter/material.dart';

class HeaterControlScreen extends StatefulWidget {
  @override
  _HeaterControlScreenState createState() => _HeaterControlScreenState();
}

class _HeaterControlScreenState extends State<HeaterControlScreen> {
  double _currentTemperature = 22;
  Set<int> _selectedIndexes = {}; // Armazena os botões selecionados

  void _updateTemperature(double delta) {
    setState(() {
      _currentTemperature = (_currentTemperature + delta).clamp(10, 30);
    });
  }

  void _onNavButtonTapped(int index) {
    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index); // Desseleciona se já estiver selecionado
      } else {
        _selectedIndexes.add(index); // Seleciona
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black54),
            onPressed: () {},
          ),
        ],
        title: Text("Heater", style: TextStyle(color: Colors.black54)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onPanUpdate: (details) {
              _updateTemperature(details.delta.dy * -0.1);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey[300]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.grey[300]!, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HEATING",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${_currentTemperature.toInt()}°",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Icon(Icons.eco, color: Colors.green, size: 28),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5),
              ],
            ),
            child: DropdownButton<String>(
              value: "Device 1",
              underline: SizedBox(),
              icon: Icon(Icons.keyboard_arrow_down),
              items: ["Device 1", "Device 2", "Device 3"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 0), // Aproxima dos botões
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoCard("Inside humidity", "49%", Icons.water_drop),
                SizedBox(width: 20),
                _buildInfoCard("Outside Temp.", "8°", Icons.thermostat),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavButton(Icons.local_fire_department, "MODE", 0),
                _buildNavButton(Icons.eco, "ECO", 1),
                _buildNavButton(Icons.schedule, "SCHEDULE", 2),
                _buildNavButton(Icons.history, "HISTORY", 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      width: 170, // Aumenta o tamanho do card
      height: 200, // Aumenta a altura
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(3, 3),
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  offset: Offset(-3, -3),
                ),
              ],
            ),
            child: Icon(icon, size: 28, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 5),
          Text(value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label, int index) {
    bool isActive = _selectedIndexes.contains(index);

    return GestureDetector(
      onTap: () => _onNavButtonTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isActive
                  ? LinearGradient(
                      colors: [Colors.purple, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isActive ? null : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(3, 3),
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  offset: Offset(-3, -3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey,
              size: 28,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.purple : Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
