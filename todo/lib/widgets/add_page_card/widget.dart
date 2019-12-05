import 'package:flutter/material.dart';
import 'package:todo/pages/add_card_screen.dart';

class AddPageCard extends StatelessWidget {
  final Color color;

  const AddPageCard({Key key, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Material(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AddCardScreen(),
                ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 52.0,
                      color: color,
                    ),
                    Container(
                      height: 8.0,
                    ),
                    Text(
                      'Add Category',
                      style: TextStyle(color: color),
                    )
                  ],
                ),
              ),
            )));
  }
}
