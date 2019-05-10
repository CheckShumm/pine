
import 'package:flutter/material.dart';
import 'package:pine/src/utils/CustomShapeClipper.dart';

class WaveShapeClipper extends StatelessWidget {

  @required final double heightPercentage;
  @required final String title;
  @required final Color color;
  @required final double fontSize;

  WaveShapeClipper({this.heightPercentage, this.fontSize, this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                      height: MediaQuery.of(context).size.height * heightPercentage,
                      color: this.color,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 32.0),
                            child: Text(this.title,
                                style: TextStyle(
                                    fontSize: this.fontSize, color: Colors.white)),
                          )
                        ],
                      )));
  }
}