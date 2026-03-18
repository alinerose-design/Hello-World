import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppState extends ChangeNotifier {
  Map<String, Map<String, String>> userAccounts = {};
  String? loggedInEmail;

  List<Map<String, String>> favorites = [];
  List<Map<String, String>> cart = [];

  AppState() {
    _loadFromPrefs();
  }

  bool get isLoggedIn => loggedInEmail != null;

  Map<String, String>? get currentUser =>
      loggedInEmail != null ? userAccounts[loggedInEmail] : null;

  Set<String> get favoritesSet =>
      favorites.map((e) => e['name'] ?? '').toSet();

  void login(String email, String password) {
    loggedInEmail = email;
    _saveToPrefs();
    notifyListeners();
  }

  void logout() {
    loggedInEmail = null;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String city,
    required String postalCode,
    required String address,
  }) async {
    userAccounts[email] = {
      'name': name,
      'email': email,
      'password': password,
      'city': city,
      'postalCode': postalCode,
      'address': address,
    };

    loggedInEmail = email;
    await _saveToPrefs();
    notifyListeners();
  }

  void updateUserField(String key, String value) {
    if (loggedInEmail != null) {
      userAccounts[loggedInEmail!]?[key] = value;
      _saveToPrefs();
      notifyListeners();
    }
  }

  Future<void> deleteAccount() async {
    if (loggedInEmail != null) {
      userAccounts.remove(loggedInEmail);
      loggedInEmail = null;
      favorites.clear();
      cart.clear();
      await _saveToPrefs();
      notifyListeners();
    }
  }

  void toggleFavorite(Map<String, String> product) {
    final name = product['name'] ?? '';

    final exists =
    favorites.any((p) => (p['name'] ?? '') == name);

    if (exists) {
      favorites.removeWhere((p) => (p['name'] ?? '') == name);
    } else {
      favorites.add(Map<String, String>.from(product));
    }

    _saveToPrefs();
    notifyListeners();
  }

  void addToCart(Map<String, String> product) {
    cart.add(Map<String, String>.from(product));
    _saveToPrefs();
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('users', jsonEncode(userAccounts));
    prefs.setString('loggedInEmail', loggedInEmail ?? '');
    prefs.setString('favorites', jsonEncode(favorites));
    prefs.setString('cart', jsonEncode(cart));
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final usersStr = prefs.getString('users');
    final loggedEmail = prefs.getString('loggedInEmail');
    final favStr = prefs.getString('favorites');
    final cartStr = prefs.getString('cart');

    if (usersStr != null) {
      final Map<String, dynamic> jsonUsers = jsonDecode(usersStr);
      userAccounts = jsonUsers.map(
            (key, value) =>
            MapEntry(key, Map<String, String>.from(value)),
      );
    }

    loggedInEmail =
    (loggedEmail != null && loggedEmail.isNotEmpty)
        ? loggedEmail
        : null;

    if (favStr != null) {
      final List list = jsonDecode(favStr);
      favorites =
          list.map((e) => Map<String, String>.from(e)).toList();
    }

    if (cartStr != null) {
      final List list = jsonDecode(cartStr);
      cart = list.map((e) => Map<String, String>.from(e)).toList();
    }

    notifyListeners();
  }
}