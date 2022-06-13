import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = 'AIzaSyBYO0Mts3hJoA9jE4u-yrW3AP6QqJWTa64';

class Auth with ChangeNotifier {
  late String _token;
  late String _expiryDate;
  late String _userId;

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');

    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print('______JSON BODY_________');
    print(json.decode(response.body));
  }
}
