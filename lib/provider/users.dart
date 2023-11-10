// ignore_for_file: unused_field, unused_import, unused_local_variable, unnecessary_null_comparison

import 'dart:convert';
import 'dart:math';
import 'package:cadastrodeusuarios/data/dummy_users.dart';
import 'package:cadastrodeusuarios/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseUrl =
      'https://cadastrofirebase-3df0a-default-rtdb.firebaseio.com/';
  final Map<String, User> _items = {};

  Users() {
    // Ao criar a instância de Users, chame automaticamente fetchUsers
    fetchUsers();
  }

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  Future fetchUsers() async {
    final response = await http.get(Uri.parse("$_baseUrl/users.json"));
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data != null) {
      data.forEach((key, value) {
        _items[key] = User(
          id: key,
          name: value['name'],
          email: value['email'],
          avatarUrl: value['avatarUrl'],
        );
      });
    }
    notifyListeners();
  }

  Future put(User? user) async {
    if (user == null) {
      return;
    }
//alterar
    if (user.id != null && _items.containsKey(user.id)) {
      await http.patch(
        Uri.parse("$_baseUrl/users.json/${user.id}.json"),
        body: jsonEncode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );
      _items.update(
          user.id!,
          (_) => User(
                id: user.id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
//adicionar
    } else {
      final response = await http.post(
        Uri.parse("$_baseUrl/users.json"),
        body: jsonEncode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );
      final id = jsonDecode(response.body)['name'];

      _items.putIfAbsent(
          id,
          () => User(
                id: id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    }
    notifyListeners();
  }

  Future remove(User? user) async {
    if (user != null && user.id != null) {
      final response = await http.delete(
        Uri.parse("$_baseUrl/users/${user.id}.json"),
      );
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
