import 'package:flutter/material.dart';

typedef void Callback();

class DeleteAlertDialog extends StatelessWidget {
  final Color color;
  final Callback onActionPressed;

  DeleteAlertDialog({@required this.color, @required this.onActionPressed});

  Widget build(BuildContext context) {
    return FlatButton(
      textColor: color,
      child: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete this card?'),
              content: SingleChildScrollView(
                child: Text(
                    'This is a one way street! Deleting this will remove all the task assigned in this card.'),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onActionPressed();
                  },
                ),
                FlatButton(
                  child: Text('Cacel'),
                  textColor: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        );
      },
    );
  }
}
