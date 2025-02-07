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

  @override
  Widget build(BuildContext context) {
    return Column(
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
              children: _activeTabIndex == 0
                  ? List.generate(6, (index) => Smartcard(
                        imagePath: 'lib/assets/quarto.png',
                        title: 'Master Bedroom',
                        subtitle: '4 Devices',
                        type: "room",
                      ))
                  : List.generate(6, (index) => Smartcard(
                        imagePath: 'lib/assets/aaaipad.png',
                        title: 'Heater',
                        subtitle: '4 Devices',
                        type: "device",
                      )),
            ),
          ),
        ),
      ],
    );
  }
}
