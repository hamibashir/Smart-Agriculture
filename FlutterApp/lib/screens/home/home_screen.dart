import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../fields/fields_screen.dart';
import '../irrigation/irrigation_screen.dart';
import '../recommendations/recommendations_screen.dart';
import '../alerts/alerts_screen.dart';
import '../profile/profile_screen.dart';
import '../test_field/test_field_screen.dart';
import '../sensor_management/sensor_binding_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void navigateToTab(int index) {
    setState(() => _currentIndex = index);
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    const FieldsScreen(),
    const IrrigationScreen(),
    const RecommendationsScreen(),
    const AlertsScreen(),
    const ProfileScreen(),
  ];

  Future<bool> _onWillPop() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.exit_to_app, color: Colors.red),
            SizedBox(width: 12),
            Text('Exit App'),
          ],
        ),
        content: const Text('Are you sure you want to exit the app?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Add a floating action button for quick access to test field
    final isTestFieldTab = _currentIndex == 0; // Only show on dashboard
    final fab = isTestFieldTab
        ? FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, TestFieldScreen.routeName);
            },
            icon: const Icon(Icons.science, color: Colors.white),
            label: const Text('Test Field'),
            backgroundColor: Colors.green,
            heroTag: 'test_field_fab',
          )
        : null;

    // Add a sensor management button to the app bar
    final appBar = AppBar(
      title: const Text('Smart Agriculture'),
      actions: [
        if (_currentIndex == 0) // Only show on dashboard
          IconButton(
            icon: const Icon(Icons.settings_input_component),
            tooltip: 'Manage Sensors',
            onPressed: () {
              Navigator.pushNamed(context, SensorBindingScreen.routeName);
            },
          ),
      ],
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: fab,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
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
