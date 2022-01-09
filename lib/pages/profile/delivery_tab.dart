import 'package:flutter/material.dart';

class Profiledelivery extends StatefulWidget {
  @override
  _ProfiledeliveryState createState() => _ProfiledeliveryState();
}

class _ProfiledeliveryState extends State<Profiledelivery> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (c, index) {
          return Card(
              child: ListTile(
            leading: CircleAvatar(
              child: Text("F"),
            ),
            title: Text("Order: 1023"),
            subtitle: Text("Delevery date: 10,June"),
            trailing: Icon(Icons.done),
          ));
        });
  }
}
