import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/library.dart';

class Register extends StatefulWidget {
  Register({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formGlobalKey = GlobalKey<FormState>();

  var getUsername;

  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass1 = TextEditingController();
  TextEditingController controllerPass2 = TextEditingController();

  registerOnPressed() {
    String user = controllerUser.text;
    String pass1 = controllerPass1.text;

    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();

      final firestoreInstance = FirebaseFirestore.instance;

      firestoreInstance
          .collection("users")
          .doc(user)
          .set(
            {
              "username": user,
              "password": md5Hash(pass1),
            },
          )
          .then((value) => print("Register Success"))
          .catchError((error) => print("Register Failed"));

      goToLoginPage(context);
    }
  }

  usernameOnChanged(text) {
    String username = controllerUser.text;

    final firestoreInstance = FirebaseFirestore.instance;

    firestoreInstance
        .collection("users")
        .doc(username)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print("Username already taken");
      } else {}
    });
  }

  passwordValidator(pass) {
    String pass1 = controllerPass1.text;

    if (pass1 == pass) {
      return null;
    } else {
      return "Password didn't match";
    }
  }

  loginOnPressed() {
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
              Colors.lightGreen,
              Colors.green,
            ],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: formGlobalKey,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 64, 16, 48),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Form(
                        key: formGlobalKey,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(40, 8, 16, 0),
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
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outlined,
                                    color: Colors.white70,
                                  ),
                                ),
                                onChanged: (text) {
                                  usernameOnChanged(text);
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                validator: (username) {
                                  final firestoreInstance =
                                      FirebaseFirestore.instance;

                                  firestoreInstance
                                      .collection('users')
                                      .doc(username)
                                      .get()
                                      .then(
                                    (value) {
                                      getUsername = value.data()?['username'];
                                    },
                                  );

                                  if (username == null || username.isEmpty) {
                                    return "Username is empty";
                                  } else if (getUsername == username) {
                                    return "Username already taken";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(40, 8, 16, 0),
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
                                  controller: controllerPass1,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide:
                                          BorderSide(color: Colors.white70),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide:
                                          BorderSide(color: Colors.white70),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.vpn_key_outlined,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: (password) {
                                    if (password!.isEmpty) {
                                      return "Password is empty";
                                    } else if (password.length <= 8) {
                                      return "Password is too short";
                                    }
                                    return null;
                                  }),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(40, 8, 16, 0),
                              child: Text(
                                "Re Type Password",
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
                                controller: controllerPass2,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.white54),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.vpn_key_outlined,
                                    color: Colors.white70,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                validator: (pass1) {
                                  // String pass1 = controllerPass1.text;
                                  String pass2 = controllerPass2.text;
                                  if (pass1 != pass2) {
                                    return "Password doesn't match";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  registerOnPressed();
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.green,
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
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            loginOnPressed();
                          },
                          child: Text(
                            "Sign In",
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
      ),
    );
  }
}
