import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  const UserProfile({required this.name, required this.email});

  final String name;
  final String email;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name']?.toString() ?? 'Guest',
      email: json['email']?.toString() ?? '',
    );
  }
}

class UserProfileService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  static Future<UserProfile> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final storedName = prefs.getString('name') ?? 'Guest';
    final storedEmail = prefs.getString('email') ?? '';
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      return UserProfile(name: storedName, email: storedEmail);
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          final profile = UserProfile.fromJson(decoded);

          await prefs.setString('name', profile.name);
          if (profile.email.isNotEmpty) {
            await prefs.setString('email', profile.email);
          }

          return profile;
        }
      }
    } catch (_) {
      // Fall back to cached profile data when the API is unavailable.
    }

    return UserProfile(name: storedName, email: storedEmail);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      try {
        await http.post(
          Uri.parse('$_baseUrl/logout'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      } catch (_) {
        // Clear the local session even if the network request fails.
      }
    }

    await prefs.remove('token');
    await prefs.remove('name');
    await prefs.remove('email');
  }
}
