import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/pages/auth_page/auth_register.dart';
import 'package:food_rest/pages/decision_page.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/input_field.dart';
import 'package:food_rest/widget/proceed_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthSwitchPage extends StatefulWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  _AuthSwitchPageState createState() => _AuthSwitchPageState();
}

class _AuthSwitchPageState extends State<AuthSwitchPage> {
  bool isLoading = false;
  PageController pageController;

  String phoneNumber = "";
  String otpCodeSent = "";
  String verificationId = "";

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            BackgroundWidget(),
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                buildSignIn(),
                buildOTP(),
              ],
            ),
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
          Text(
            "Enter phone number to sign in",
            style: Theme.of(context).textTheme.subtitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .20,
          ),
          CustomInputField(
            topLabel: "Enter Phone Number",
            hintText: "e.g. 09012345678",
            onChaged: (t) {
              setState(() {
                phoneNumber = t;
              });
            },
            fieldSubmitted: (t) {
              setState(() {
                phoneNumber = t;
              });
            },
            keyboardType: TextInputType.phone,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ProceedButton(
              onPressed: phoneNumber.isEmpty
                  ? null
                  : () {
                      // verifyPhoneNumber();
                      checkIfRegistered();
                      // pageController.jumpToPage(1);
                    },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext c) => AuthRegister(),
                  ),
                );
              },
              child: Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOTP() {
    return WillPopScope(
      onWillPop: () async {
        pageController.jumpToPage(0);
        return false;
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 64, 16, 16),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Enter OTP sent to Phone Number",
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.start),
                SizedBox(height: MediaQuery.of(context).size.height * .2),
                CustomInputField(
                  topLabel: "Code recieved",
                  hintText: "",
                  bottomLabel: "do not share this code with anyone",
                  onChaged: (s) {
                    setState(() {
                      otpCodeSent = s;
                    });
                  },
                  fieldSubmitted: (s) {
                    setState(() {
                      otpCodeSent = s;
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                ProceedButton(
                  text: "Done",
                  onPressed: () {
                    confirmOtp();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext c) => DecisionPage(),
                    //   ),
                    // );
                  },
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
                icon: Icon(CupertinoIcons.back),
                onPressed: () {
                  pageController.jumpToPage(0);
                }),
          ),
        ],
      ),
    );
  }

  Future<void> verifyPhoneNumber() async {
    final PhoneCodeAutoRetrievalTimeout autoRetieve = (String verid) {
      verificationId = verid;
    };

    final PhoneCodeSent smsCodeSent = (String verid, [int forceCodeResend]) {
      verificationId = verid;
      print("code sent");
      setState(() {
        isLoading = false;
        pageController.jumpToPage(1);
      });
    };

    final PhoneVerificationCompleted verifSuccess = (AuthCredential user) {
      if (user != null) {
        setState(() {
          isLoading = false;
        });
        print("success...");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext c) => DecisionPage(),
          ),
        );
      } else {
        print("completed failed...");
        setState(() {
          isLoading = false;
        });
        pageController.jumpToPage(0);
      }
    };
    final PhoneVerificationFailed verifFailed = (AuthException ex) {
      print("failed: ${ex.message}");
      setState(() {
        isLoading = false;
      });
      pageController.jumpToPage(0);
    };

    await widget._firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifSuccess,
        verificationFailed: verifFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetieve);
    print("id $verificationId == phone number $phoneNumber");
  }

  Future<void> confirmOtp() async {
    final AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: otpCodeSent);

    await widget._firebaseAuth
        .signInWithCredential(_authCredential)
        .catchError((error) {})
        .then((AuthResult authResult) {
      if (authResult != null && authResult.user != null) {
        print('Authentication successful');
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext c) => DecisionPage(),
          ),
        );
      }
    });
  }

  checkIfRegistered() async {
    setState(() {
      isLoading = true;
    });
    print("check db for number");

    Firestore.instance
        .collection('users')
        .document('$phoneNumber')
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
      if (ds != null && ds.data != null) {
        verifyPhoneNumber();
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => AuthRegister()));
      }
    });
  }
}
