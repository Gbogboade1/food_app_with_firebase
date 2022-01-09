import 'package:flutter/material.dart';
import 'package:food_rest/model/addonitem_model.dart';

class AddOnItemCard extends StatelessWidget {
  final AddOnItem item;
  final bool isSelected;

  const AddOnItemCard({Key key, this.item, this.isSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name,
                style:
                    Theme.of(context).textTheme.title.apply(fontSizeDelta: 2),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Checkbox(value: isSelected, onChanged: (value) {}))
        ],
      ),
    );
  }
}
