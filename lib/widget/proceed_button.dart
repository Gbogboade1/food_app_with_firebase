import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProceedButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const ProceedButton({
    Key key,
    this.text = "Proceed",
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
