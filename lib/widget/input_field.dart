import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String topLabel;
  final String hintText;
  final String bottomLabel;
  final Function onChaged;
  final TextInputType keyboardType;
  final bool isPassWord;
  final bool isMultiLine;
  final TextEditingController controller;
  final Function fieldSubmitted;

  CustomInputField({
    Key key,
    this.topLabel = "",
    this.hintText = "",
    this.bottomLabel = "",
    this.onChaged,
    this.keyboardType = TextInputType.text,
    this.isPassWord = false,
    this.isMultiLine = false,
    this.controller,
    this.fieldSubmitted,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool showPassWord;
  @override
  void initState() {
    super.initState();
    showPassWord = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(widget.topLabel),
            SizedBox(width: 8),
            Icon(Icons.lock, size: 10),
          ],
        ),
        SizedBox(height: 4),
        Card(
          margin: EdgeInsets.all(0),
          color: Colors.transparent,
          child: LimitedBox(
            maxHeight: MediaQuery.of(context).size.height * .25,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4.0),
              child: !widget.isPassWord
                  ? TextFormField(
                      onFieldSubmitted: widget.fieldSubmitted,
                      controller: widget.controller,
                      onChanged: widget.onChaged,
                      keyboardType: widget.keyboardType,
                      obscureText: widget.isPassWord,
                      maxLines: widget.isMultiLine ? null : 1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.hintText,
                          fillColor: Colors.grey),
                    )
                  : Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            onFieldSubmitted: widget.fieldSubmitted,
                            controller: widget.controller,
                            maxLines: widget.isMultiLine ? null : 1,
                            onChanged: widget.onChaged,
                            keyboardType: widget.keyboardType,
                            obscureText: showPassWord,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.hintText,
                                fillColor: Colors.grey),
                          ),
                        ),
                        SizedBox(width: 4),
                        IconButton(
                            icon: Icon(
                                showPassWord
                                    ? Icons.lock_outline
                                    : Icons.lock_open,
                                size: 16),
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  showPassWord = !showPassWord;
                                });
                              }
                            })
                      ],
                    ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          widget.bottomLabel,
          style: Theme.of(context).textTheme.overline,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        )
      ],
    );
  }
}
