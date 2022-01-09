import 'package:flutter/material.dart';

class SelectionChip extends StatelessWidget {
  final String title;
  final bool isSelected;

  const SelectionChip({Key key, this.title, this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: StadiumBorder(),
      color: !isSelected ? Colors.white : Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: isSelected ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
