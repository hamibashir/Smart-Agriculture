import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../fields/fields_screen.dart';
import '../irrigation/irrigation_screen.dart';
import '../recommendations/recommendations_screen.dart';
import '../alerts/alerts_screen.dart';
import '../profile/profile_screen.dart';
import '../../config/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigateToTab(int index) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

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
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // Prevents swipe-conflicts with other horizontal scroll widgets
          children: const [
            DashboardScreen(),
            FieldsScreen(),
            IrrigationScreen(),
            RecommendationsScreen(),
            AlertsScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            navigationBarTheme: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.textPrimary);
                }
                return const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey);
              }),
            ),
          ),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: navigateToTab,
            backgroundColor: Colors.white,
            indicatorColor: AppTheme.primaryGreen.withValues(alpha: 0.15),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            elevation: 8,
            shadowColor: Colors.black.withValues(alpha: 0.05),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded, color: AppTheme.primaryGreen), label: 'Dashboard'),
              NavigationDestination(icon: Icon(Icons.grass_outlined), selectedIcon: Icon(Icons.grass_rounded, color: AppTheme.primaryGreen), label: 'Fields'),
              NavigationDestination(icon: Icon(Icons.water_drop_outlined), selectedIcon: Icon(Icons.water_drop_rounded, color: AppTheme.primaryGreen), label: 'Irrigation'),
              NavigationDestination(icon: Icon(Icons.eco_outlined), selectedIcon: Icon(Icons.eco_rounded, color: AppTheme.primaryGreen), label: 'Tips'),
              NavigationDestination(icon: Icon(Icons.notifications_outlined), selectedIcon: Icon(Icons.notifications_rounded, color: AppTheme.primaryGreen), label: 'Alerts'),
              NavigationDestination(icon: Icon(Icons.person_outlined), selectedIcon: Icon(Icons.person_rounded, color: AppTheme.primaryGreen), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
