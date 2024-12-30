import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ThemePreferenceDemo(),
    );
  }
}

class ThemePreferenceDemo extends StatefulWidget {
  const ThemePreferenceDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThemePreferenceDemoState createState() => _ThemePreferenceDemoState();
}

class _ThemePreferenceDemoState extends State<ThemePreferenceDemo> {
  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  // Function to save theme preference
  Future<void> _saveThemePreference(bool isDarkTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', isDarkTheme ? 'dark' : 'light');
  }

  // Function to load theme preference
  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.setString('theme');
    setState(() {
      _isDarkTheme = (theme == 'dark');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Preference Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Theme: ${_isDarkTheme ? "Dark" : "Light"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Switch(
              value: _isDarkTheme,
              onChanged: (value) {
                setState(() {
                  _isDarkTheme = value;
                  _saveThemePreference(value);
                });
              },
            ),
          ],
        ),
      ),
      backgroundColor: _isDarkTheme ? Colors.grey[850] : Colors.white,
    );
  }
}

class SharedPreferences {
  static getInstance() {}
  
  setString(String s, String t) {}
}
