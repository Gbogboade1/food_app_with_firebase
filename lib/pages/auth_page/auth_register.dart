import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/model/user_model.dart';
import 'package:food_rest/pages/auth_page/auth_page.dart';
import 'package:food_rest/pages/decision_page.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/input_field.dart';
import 'package:food_rest/widget/proceed_button.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRegister extends StatefulWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  _AuthRegisterState createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
  PageController pageController;
  final int totalPages = 6;
  double progressValue = 1 / 6;

  String phoneNumber = "";
  String otpCodeSent = "";
  String verificationId = "";

  bool isLoading = false;

  String firstName = "";
  String lastName = "";
  String emailAddress = "";
  String city = "";
  String deliveryAddr = "";
  String pin = "";
  String confirmpin = "";
  List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: 0, keepPage: true);
    controllers = List.generate(9, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            BackgroundWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: PageView(
                onPageChanged: (pageIndex) {
                  setState(() {
                    progressValue = (pageIndex + 1) / totalPages;
                  });
                },
                controller: pageController,
                children: List.generate(totalPages, (index) {
                  return step(index);
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext c) => AuthPage()));
                      },
                      icon: Icon(CupertinoIcons.back,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progressValue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  step(index) {
    switch (index) {
      case 0:
        return stepName();
      case 1:
        return stepEmail();
      case 2:
        return stepAddress();
      case 3:
        return stepPin();
      case 4:
        return stepPhoneNumber();
      case 5:
        return stepOTP();

        break;
      default:
    }
    return stepName();
    // return Center(child: Text("Step $index"));
  }

  stepName() {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext c) => AuthPage()));
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("What\'s your name?",
                          style: Theme.of(context).textTheme.title,
                          textAlign: TextAlign.start),
                    ],
                  ),
                  SizedBox(height: 32),
                  CustomInputField(
                    topLabel: "First name",
                    hintText: "e.g. James",
                    onChaged: (s) {
                      firstName = s;
                    },
                    fieldSubmitted: (s) {
                      firstName = s;
                    },
                    controller: controllers[0],
                  ),
                  SizedBox(height: 16),
                  CustomInputField(
                    topLabel: "Last name",
                    hintText: "e.g. Bond",
                    bottomLabel: "we use this to personalize your profile",
                    onChaged: (s) {
                      setState(() {
                        lastName = s;
                      });
                    },
                    fieldSubmitted: (s) {
                      setState(() {
                        lastName = s;
                      });
                    },
                    controller: controllers[1],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProceedButton(
                text: "Continue",
                onPressed: firstName.trim().isEmpty && lastName.trim().isEmpty
                    ? null
                    : () {
                        // firstName = controllers[0].value.text;
                        // lastName = controllers[1].value.text;
                        pageController.jumpToPage(1);
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  stepEmail() {
    return WillPopScope(
      onWillPop: () async {
        pageController.jumpToPage(0);
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
        child: Stack(
          children: <Widget>[
            ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("And, your email?",
                        style: Theme.of(context).textTheme.title,
                        textAlign: TextAlign.start),
                  ],
                ),
                SizedBox(height: 32),
                CustomInputField(
                  topLabel: "Email address",
                  hintText: "e.g. James",
                  bottomLabel:
                      "we use this to let you know about changes to your account.",
                  onChaged: (s) {
                    setState(() {
                      emailAddress = s;
                    });
                  },
                  fieldSubmitted: (s) {
                    setState(() {
                      emailAddress = s;
                    });
                  },
                  controller: controllers[2],
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProceedButton(
                text: "Continue",
                onPressed: emailAddress.isEmpty
                    ? null
                    : () {
                        pageController.jumpToPage(2);
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  stepAddress() {
    return WillPopScope(
      onWillPop: () async {
        pageController.jumpToPage(1);
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Where do you want us to deliver your packages?",
                      style: Theme.of(context).textTheme.title,
                      textAlign: TextAlign.start),
                  SizedBox(height: 32),
                  CustomInputField(
                    topLabel: "City",
                    hintText: "e.g. Akure",
                    onChaged: (s) {
                      setState(() {
                        city = s;
                      });
                    },
                    fieldSubmitted: (s) {
                      setState(() {
                        city = s;
                      });
                    },
                    controller: controllers[3],
                    isMultiLine: true,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 16),
                  CustomInputField(
                    topLabel: "Delivery address",
                    hintText: "e.g. 12, Arakale street,FUTA Southgate",
                    bottomLabel:
                        "This should contain house number, street and neaest bus-stop.",
                    onChaged: (s) {
                      setState(() {
                        deliveryAddr = s;
                      });
                    },
                    fieldSubmitted: (s) {
                      setState(() {
                        deliveryAddr = s;
                      });
                    },
                    controller: controllers[4],
                    isMultiLine: true,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProceedButton(
                text: "Continue",
                onPressed: deliveryAddr.isEmpty
                    ? null
                    : () {
                        pageController.jumpToPage(3);
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  stepPin() {
    return WillPopScope(
      onWillPop: () async {
        pageController.jumpToPage(2);
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Create a pin",
                          style: Theme.of(context).textTheme.title,
                          textAlign: TextAlign.start),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Six-digit code you\'ll use to authenticate account",
                      style: Theme.of(context).textTheme.title,
                      textAlign: TextAlign.start),
                  SizedBox(height: 32),
                  CustomInputField(
                    topLabel: "Pin",
                    hintText: "******",
                    bottomLabel:
                        "try to use a memorable code, pin must be exactly 6 digits ",
                    onChaged: (s) {
                      setState(() {
                        pin = s;
                      });
                    },
                    fieldSubmitted: (s) {
                      setState(() {
                        pin = s;
                      });
                    },
                    controller: controllers[5],
                    keyboardType: TextInputType.number,
                    isPassWord: true,
                  ),
                  SizedBox(height: 16),
                  CustomInputField(
                    topLabel: "Re-enter Pin",
                    hintText: "******",
                    bottomLabel: "pin must match to proceed ",
                    onChaged: (s) {
                      setState(() {
                        confirmpin = s;
                      });
                    },
                    fieldSubmitted: (s) {
                      setState(() {
                        confirmpin = s;
                      });
                    },
                    controller: controllers[6],
                    keyboardType: TextInputType.number,
                    isPassWord: true,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProceedButton(
                text: "Continue",
                onPressed: pin.length != 6 || confirmpin.length != 6
                    ? null
                    : () {
                        pageController.jumpToPage(4);
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  stepPhoneNumber() {
    return WillPopScope(
      onWillPop: () async {
        pageController.jumpToPage(3);
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Almost Done!",
                        style: Theme.of(context).textTheme.title,
                        textAlign: TextAlign.start),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Phone Number",
                        style: Theme.of(context).textTheme.title,
                        textAlign: TextAlign.start),
                  ],
                ),
                SizedBox(height: 32),
                CustomInputField(
                    topLabel: "Phone Number",
                    hintText: "e.g. 09012345678",
                    bottomLabel:
                        "this will be required to sign-in, \nA confirmation one-time-pin (OTP) will be sent to this number",
                    onChaged: (s) {
                      setState(() {
                        phoneNumber = s;
                      });
                    },
                    fieldSubmitted: (s) {
                      setState(() {
                        phoneNumber = s;
                      });
                    },
                    controller: controllers[7],
                    keyboardType: TextInputType.phone),
                SizedBox(height: 16),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProceedButton(
                text: "Continue",
                onPressed: phoneNumber.isEmpty
                    ? null
                    : () {
                        confirmPhoneNumberDialog();
                        // setState(() {
                        //   isLoading = true;
                        // });
                        // verifyPhoneNumber();
                      },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(height: 0, width: 0),
            ),
          ],
        ),
      ),
    );
  }

  stepOTP() {
    return WillPopScope(
      onWillPop: () async {
        pageController.jumpToPage(4);
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
        child: Stack(
          children: <Widget>[
            ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Enter OTP sent to Phone Number",
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.start),
                SizedBox(height: 32),
                CustomInputField(
                  topLabel: "Code recieved",
                  hintText: "",
                  bottomLabel: "do not share this code with anyone",
                  onChaged: (s) {
                    otpCodeSent = s;
                  },
                  fieldSubmitted: (s) {
                    otpCodeSent = s;
                  },
                  controller: controllers[8],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProceedButton(
                text: "Done",
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });

                  confirmOtp();
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(height: 0, width: 0),
            ),
          ],
        ),
      ),
    );
  }

  confirmPhoneNumberDialog() async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Confirm phone number"),
        content: Text("Kindly confirm your phone number \n$phoneNumber"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              verifyPhoneNumber();
              Navigator.pop(context, true);
            },
            child: Text("Proceed"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Edit Number"),
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
        pageController.jumpToPage(5);
      });
    };

    final PhoneVerificationCompleted verifSuccess = (AuthCredential user) {
      if (user != null) {
        print("success...");
        addToDatabase();
      } else {
        print("completed failed...");
        setState(() {
          isLoading = false;
        });
        pageController.jumpToPage(4);
      }
    };
    final PhoneVerificationFailed verifFailed = (AuthException ex) {
      print("failed: ${ex.message}");
      setState(() {
        isLoading = false;
      });
      pageController.jumpToPage(4);
    };

    await widget._firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
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

        addToDatabase();
      }
    });
  }

  addToDatabase() async {
    print("adding to database");
    User user = User(
      phoneNumber: phoneNumber,
      securityPin: pin,
      lastName: lastName,
      firstName: firstName,
      address: deliveryAddr,
      emailAddr: emailAddress,
    );
    await Firestore.instance
        .collection('users')
        .document(phoneNumber)
        .setData(user.toJson())
        .then(
      (value) {
        setState(() {
          isLoading = false;
        });
        print("complete");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext c) => DecisionPage(),
          ),
        );
      },
      onError: (e) {},
    );
  }


}
