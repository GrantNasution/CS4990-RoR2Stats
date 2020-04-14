import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'logview.dart';
import 'newlog.dart';
import 'log.dart';
import 'database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoR2 Stat Log',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.black,),
        primaryColor: Colors.black,
        dividerColor: Color(0xffffcc00),
        scaffoldBackgroundColor: Color(0xFF13131a), 
        textTheme: TextTheme(),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomePageState createState() => HomePageState();
}
enum Views {addLog, viewLog}

class HomePageState extends State<HomePage> {
  final _newLogPage = new NewLogPage(isnewLog: false);
  final List<Log> _savedLogs = List<Log>();
  final LocalStorage storage = new LocalStorage('logs');
  int viewIndex = 0;
  bool initialized = false;

  TextStyle _getTextStyle() {
    return TextStyle(fontSize: 25.0, color: Color(0xffffcc00));
  }
  TextStyle _getAppBarTextStyle() {
    return TextStyle(color: Color(0xffddf2f4));
  }

  //Builds list of all logs
  Widget _buildLogs() {
    return ListView.builder(
      itemCount: (_savedLogs.length * 2),
      itemBuilder: (context, i) {
        if(i.isOdd) {
          return Divider(thickness: 0.5, color: Color(0xff2fc7e0));
        }
        final index = i ~/ 2;
        //If more rows to build, build it
        if(index < _savedLogs.length) {
          return _buildRow(_savedLogs[index], index);
        }
        //If no more rows return dividers
        else {
          return Divider(thickness: 0.5);
        }
      }
    );
  }

  //Builds a row populated with log data
  Widget _buildRow(Log log, int selectedIndex) {
    return ListTile(
      title: Text(
        log.gClass,
        style: _getTextStyle(),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Color(0xffffcc00),
      ),
      onTap:() {
        //Set which index to view
        viewIndex = selectedIndex;
        _pushView(Views.viewLog);
      },
    );
  }

  //Stores all _savedLogs onto prefs
  Future<void> _saveLogsToPref() async {
    // final SharedPreferences prefs = await _prefs;
    // int i = 0;
    // _savedLogs.forEach((log) {
    //   prefs.setString(i.toString(), log.stringify());
    //   ++i;
    // });
  }

  //Load logs if not initailized
  void initialize() {
    // _prefs.then((SharedPreferences prefs) {
    //   int i = 0;
    //   String logString;
    //   print(logString + "Yo");
    //    while(prefs.containsKey(i.toString())) {
    //      logString = prefs.getString(i.toString());
    //      parseLog(logString);
    //    }
    //    initialized = true;
    // });
  }

  //Parses log string stored in prefs and inserts the new log onto _savedLogs
  void parseLog(String logAsString) {
    List<String> split = logAsString.split(' ');
    _savedLogs.insert(0, Log(
      lclass: split[0], 
      kills: int.parse(split[1]), 
      minionKills: int.parse(split[2]), 
      deaths: int.parse(split[3]), 
      damageDealt: int.parse(split[4]), 
      minionDamageDealt: int.parse(split[5])));
  }

  @override
  Widget build(BuildContext context) {
    if(_newLogPage.isnewLog) {
      _savedLogs.insert(0, Log.clone(_newLogPage.newLog));
      _newLogPage.setFalse();
      _saveLogsToPref();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "RoR2 Stat Log", 
          style: _getAppBarTextStyle()
          ),
        actions: <Widget>[
          PopupMenuButton<Views>(
            onSelected: (Views selected) {
              _pushView(selected);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Views>>[
              PopupMenuItem<Views>(
                value: Views.addLog,
                child: Text(
                  'Add New Log',
                  style: _getTextStyle(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
              child: Builder(
                builder: (BuildContext context) {
                  // if(!initialized) {
                  //   initialize();
                  //   return CircularProgressIndicator(
                  //   );
                  // }
                  // else {
                  //   _buildLogs();
                  // }
                  return _buildLogs();
                }
              )
            ),
    );
  }

  //Method to push views onto navigator stack
  void _pushView(Views pushView) {
    switch(pushView) {
      case Views.addLog:
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return _newLogPage;
              },
            )
          );
        break;
      case Views.viewLog:
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return LogView(_savedLogs[viewIndex]);
            }
          ),
        );
        // TODO: Handle this case.
        break;
    }
  }
}
