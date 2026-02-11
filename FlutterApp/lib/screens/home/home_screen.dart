import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../fields/fields_screen.dart';
import '../irrigation/irrigation_screen.dart';
import '../recommendations/recommendations_screen.dart';
import '../alerts/alerts_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void navigateToTab(int index) {
    if (_currentIndex != index) setState(() => _currentIndex = index);
  }

  Widget get _currentScreen => switch (_currentIndex) {
        0 => const DashboardScreen(),
        1 => const FieldsScreen(),
        2 => const IrrigationScreen(),
        3 => const RecommendationsScreen(),
        4 => const AlertsScreen(),
        _ => const ProfileScreen(),
      };

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
        if (shouldPop == true && context.mounted) Navigator.pop(context);
      },
      child: Scaffold(
        body: _currentScreen,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: navigateToTab,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grass_outlined),
              activeIcon: Icon(Icons.grass),
              label: 'Fields',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.water_drop_outlined),
              activeIcon: Icon(Icons.water_drop),
              label: 'Irrigation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.eco_outlined),
              activeIcon: Icon(Icons.eco),
              label: 'Crops',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              activeIcon: Icon(Icons.notifications),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
