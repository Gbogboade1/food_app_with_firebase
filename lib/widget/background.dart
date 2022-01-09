import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Opacity(
        opacity: 0.3,
        child: Image.asset(
          "assets/food5.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
class BackgroundWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Opacity(
        opacity: 0.3,
        child: Image.asset(
          "assets/fs_back.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
