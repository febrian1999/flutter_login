import 'package:flutter/material.dart';
import 'package:flutter_login/library.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  logoutOnPressed() {
    goToLoginPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.yellow,
              Colors.yellowAccent,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                // height: double.infinity,
                child: Text(
                  "Hello World!",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    logoutOnPressed();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black45,
                    minimumSize: Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
