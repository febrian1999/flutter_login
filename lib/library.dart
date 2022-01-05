import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/register.dart';
import 'package:flutter_login/home.dart';
import 'package:flutter_login/login.dart';

goToHomePage(context) {
  try {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(
          title: 'Home',
        ),
      ),
    );
  } on Exception catch (e) {
    print(e);
  }
}

goToLoginPage(context) {
  try {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Login(
          title: 'Login',
        ),
      ),
    );
  } on Exception catch (e) {
    print(e);
  }
}

goToRegisterPage(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => Register(
        title: 'Register',
      ),
    ),
  );
}

md5Hash(string) {
  String hash = md5.convert(utf8.encode(string)).toString();
  return hash;
}
