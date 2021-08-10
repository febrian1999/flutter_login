import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/library.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  loginOnPressed() {
    final firestoreInstance = FirebaseFirestore.instance;

    String username = controllerUser.text;
    String password = controllerPass.text;
    String hashpass;

    firestoreInstance.collection('users').doc(username).get().then(
      (value) {
        hashpass = value.data()?['password'];
        if (md5Hash(password) == hashpass) {
          goToHomePage(context);
        }
      },
    );
  }

  registerOnPressed() {
    goToRegisterPage(context);
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
              Colors.lightBlue,
              Colors.blue,
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 64, 16, 48),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 16, 16, 0),
                      child: Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56,
                      child: TextFormField(
                        controller: controllerUser,
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outlined,
                            color: Colors.white70,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 16, 16, 0),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56,
                      child: TextFormField(
                        controller: controllerPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key_outlined,
                            color: Colors.white70,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          loginOnPressed();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
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
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          registerOnPressed();
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
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
