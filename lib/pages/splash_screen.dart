import 'package:flutter/material.dart';
import 'package:food_rest/pages/auth_page/auth_page.dart';

class SpalshScreen extends StatefulWidget {
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  int counter = 0;
  double x = 200;
  double y = 200;
  List<Widget> images = [
    Image.asset(
      "assets/food3.jpeg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/food4.jpeg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/food5.jpeg",
      fit: BoxFit.cover,
    ),
  ];

  
  @override
  void initState() {
    super.initState();
    gotoHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: counter == 0
                ? MediaQuery.of(context).size.height * 0.5
                : counter == 1
                    ? MediaQuery.of(context).size.height * 0.7
                    : MediaQuery.of(context).size.height,
            width: counter == 0
                ? MediaQuery.of(context).size.width * 0.5
                : counter == 1
                    ? MediaQuery.of(context).size.width * 0.7
                    : MediaQuery.of(context).size.width,
            child: images[counter],
          ),
        ),
      ),
    );
  }

  gotoHome() async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (mounted) {
      setState(() {
        counter += 1;
      });
    }
    await Future.delayed(Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        counter += 1;
      });
    }
    await Future.delayed(Duration(milliseconds: 1500));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext c) => AuthPage(),
      ),
    );
  }
}
