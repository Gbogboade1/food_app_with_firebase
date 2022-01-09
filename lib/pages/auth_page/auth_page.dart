import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/model/user_model.dart';
import 'package:food_rest/pages/auth_page/auth_register.dart';
import 'package:food_rest/pages/auth_page/auth_switch.dart';
import 'package:food_rest/pages/decision_page.dart';
import 'package:food_rest/services/authentication.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/input_field.dart';
import 'package:food_rest/widget/proceed_button.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;
  String phoneNo = "";
  Auth auth = Auth();
  User user = User();

  getUserDetails() async {
    String phoneNumber = await auth.userPhoneNo();
    await Firestore.instance
        .collection('users')
        .document('$phoneNumber')
        .get()
        .then((DocumentSnapshot ds) async {
      // use ds as a snapshot
      if (ds != null && ds.data != null) {
        setState(() {
          user = User.fromMap(ds.data);
          print("Name: ${user.firstName}_____");
        });
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            BackgroundWidget(),
            buildSignIn(),
          ],
        ),
      ),
    );
  }

  Widget buildSignIn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "FoodRest",
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Welcome back!",
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          user.phoneNumber == null
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : Text(
                  "${user.lastName + " " + user.firstName} " +
                      "(******${user.phoneNumber.substring(user.phoneNumber.length - 4)})",
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .20,
          ),
          CustomInputField(
            isPassWord: true,
            topLabel: "Enter Pin",
            hintText: "******",
            onChaged: (t) {},
            keyboardType: TextInputType.number,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ProceedButton(
              onPressed: () {
                // if () {
                  
                // }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext c) => DecisionPage(),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext c) => AuthSwitchPage(),
                  ),
                );
              },
              child: Text(
                "Switch account",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext c) => AuthRegister(),
                  ),
                );
              },
              child: Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
