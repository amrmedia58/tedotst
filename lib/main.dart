// lib/main.dart
// Owner: team lead (do not edit without telling everyone)

import 'package:demo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TeamTodoApp());
}

class TeamTodoApp extends StatelessWidget {
  const TeamTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Todoxx',
      color: Colors.green,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
        useMaterial3: true,
        fontFamily: 'SF Pro Display', // falls back to system font on Android
      ),

      home: const LoginScreen(),
      routes: {
        '/home': (_) => const HomeScreen(),
        '/login'   : (_) => const LoginScreen(),   // Ali adds this
        // '/team'    : (_) => const TeamScreen(),    // Omar adds this
        // '/profile' : (_) => const ProfileScreen(), // Layla adds this
      },
    );
  }
}