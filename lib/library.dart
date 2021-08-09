import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/register.dart';

import 'home.dart';
import 'login.dart';

goToHomePage(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Home(
        title: 'Home',
      ),
    ),
  );
}

goToLoginPage(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Login(
        title: 'Login',
      ),
    ),
  );
}

goToRegisterPage(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Register(
        title: 'Register',
      ),
    ),
  );
}

md5Hash(string) {
  String hash = md5.convert(utf8.encode(string)).toString();
  return hash;
}
