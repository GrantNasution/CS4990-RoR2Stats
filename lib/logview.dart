import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'newlog.dart';
import 'log.dart';

class LogView extends StatefulWidget {
  
  LogView(this.log, {Key key, this.title}) :  super(key: key);
  final String title;
  final Log log;

  @override
  LogViewState createState() => LogViewState();
}

class LogViewState extends State<LogView> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text(
          widget.log.gClass,
          style: TextStyle(color: Color(0xffddf2f4)),
          ),
      ),
      body: _buildLogData(),
    );
  }

  Widget _buildLogData() {
    return ListView(
      children: <Widget>[
        Text(
          'Kills: ' + widget.log.gKills.toString(),
          style: TextStyle(
              color: Color(0xffffcc00),
          ),
        ),
        Text(
          'Minion Kills: ' + widget.log.gminionKills.toString(),
          style: TextStyle(
              color: Color(0xffffcc00),
          ),
        ),
        Text(
          'Deaths: ' + widget.log.gDeaths.toString(),
          style: TextStyle(
              color: Color(0xffffcc00),
          ),
        ),
        Text(
          'Damage Dealt: ' + widget.log.gdamageDealt.toString(),
          style: TextStyle(
              color: Color(0xffffcc00),
          ),
        ),
        Text(
          'Minion Damage Dealt: ' + widget.log.gminionDamageDealt.toString(),
          style: TextStyle(
              color: Color(0xffffcc00),
          ),
        ),
      ],
    );
  }
}