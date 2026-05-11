import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/field_selection_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';

import 'screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..init()),
        ChangeNotifierProvider(create: (_) => FieldSelectionProvider()..init()),
      ],
      child: MaterialApp(
        title: 'Smart Agriculture',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const _AuthWrapper(),
        routes: {
          '/login': (_) => const LoginScreen(),
          '/home': (_) => const HomeScreen(),
        },
      ),
    );
  }
}

class _AuthWrapper extends StatefulWidget {
  const _AuthWrapper();

  @override
  State<_AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<_AuthWrapper> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Enforce a minimum splash duration of 2.5 seconds for aesthetic animation
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() => _showSplash = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AuthProvider, ({bool isLoading, bool isAuth})>(
      selector: (_, auth) => (isLoading: auth.isLoading, isAuth: auth.isAuthenticated),
      builder: (_, state, __) {
        // We use AnimatedSwitcher to gracefully fade from Splash to Login/Home
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: (_showSplash || state.isLoading)
              ? const SplashScreen(key: ValueKey('splash'))
              : (state.isAuth
                  ? const HomeScreen(key: ValueKey('home'))
                  : const LoginScreen(key: ValueKey('login'))),
        );
      },
    );
  }
}
