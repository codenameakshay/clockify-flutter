import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show DateFormat;

void main() {
  runApp(
    ChangeNotifierProvider<DynamicTheme>(
      create: (_) => DynamicTheme(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    return MaterialApp(
      title: 'Clockify',
      theme: themeProvider.getDarkMode() ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isBinary = true;
  void changeIsBinary() {
    setState(() {
      isBinary = isBinary ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                'assets/images/logo.jfif',
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 60, 140, 231),
                    Color.fromARGB(255, 0, 234, 255),
                  ],
                ),
              ),
            ),
            Divider(
              height: 2.0,
            ),
            ListTile(
              title: Center(
                child: Text('CodeNameAKshay'),
              ),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            Divider(
              height: 2.0,
            ),
            Builder(
              builder: (context) => ListTile(
                title: Text('Toggle Dark mode'),
                leading: Icon(Icons.brightness_4),
                onTap: () {
                  setState(() {
                    themeProvider.changeDarkMode(!themeProvider.isDarkMode);
                  });
                  Navigator.pop(context);
                },
                trailing: Switch(
                  value: themeProvider.getDarkMode(),
                  onChanged: (value) {
                    setState(() {
                      themeProvider.changeDarkMode(value);
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Divider(
              height: 2.0,
            ),
            Builder(
              builder: (context) => ListTile(
                title: Text('Change clock type'),
                leading: Icon(Icons.access_time),
                onTap: () {
                  changeIsBinary();
                  Navigator.pop(context);
                },
              ),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Clockify"),
      ),
      body: isBinary ? BinaryClock() : DigitalClock(),
    );
  }
}

class DigitalTime {
  String digitalTime;
  DigitalTime() {
    DateTime now = DateTime.now();
    digitalTime = DateFormat("Hms").format(now);
  }
}

class DigitalClock extends StatefulWidget {
  DigitalClock({Key key}) : super(key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DigitalTime _now = DigitalTime();
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (v) {
      setState(() {
        _now = DigitalTime();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            padding: EdgeInsets.only(
                left: constraints.maxWidth * 0.22,
                right: constraints.maxWidth * 0.22),
            // width: constraints.maxWidth*0.8,
            // height: constraints.maxHeight*0.8,
            child: Row(
              children: <Widget>[
                Text(
                  _now.digitalTime[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.54 / 4,
                    color: Colors.red,
                  ),
                ),
                Text(
                  _now.digitalTime[1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.54 / 4,
                    color: Colors.redAccent[200],
                  ),
                ),
                Text(
                  _now.digitalTime[2],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.54 / 4,
                  ),
                ),
                Text(
                  _now.digitalTime[3],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.54 / 4,
                    color: Colors.green,
                  ),
                ),
                Text(
                  _now.digitalTime[4],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.54 / 4,
                    color: Colors.lightGreen,
                  ),
                ),
                Text(
                  _now.digitalTime[5],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.54 / 4,
                  ),
                ),
                Text(
                  _now.digitalTime[6],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.54 / 4,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  _now.digitalTime[7],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.54 / 4,
                    color: Colors.lightBlue[300],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BinaryTime {
  List<String> binaryIntegers;

  BinaryTime() {
    DateTime now = DateTime.now();
    String hhmmss = DateFormat("Hms").format(now).replaceAll(":", "");

    binaryIntegers = hhmmss
        .split('')
        .map((str) => int.parse(str).toRadixString(2).padLeft(4, '0'))
        .toList();
  }

  get hourTens => binaryIntegers[0];
  get hourOnes => binaryIntegers[1];
  get minuteTens => binaryIntegers[2];
  get minuteOnes => binaryIntegers[3];
  get secondTens => binaryIntegers[4];
  get secondOnes => binaryIntegers[5];
}

class BinaryClock extends StatefulWidget {
  BinaryClock({Key key}) : super(key: key);

  @override
  _BinaryClockState createState() => _BinaryClockState();
}

class _BinaryClockState extends State<BinaryClock> {
  BinaryTime _now = BinaryTime();
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (v) {
      setState(() {
        _now = BinaryTime();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(50),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            padding: EdgeInsets.all(constraints.maxWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClockColumn(
                  binaryInteger: _now.hourTens,
                  title: 'H',
                  color: Colors.red,
                  // rows: 2,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                ClockColumn(
                  binaryInteger: _now.hourOnes,
                  title: 'h',
                  color: Colors.redAccent[200],
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                ClockColumn(
                  binaryInteger: _now.minuteTens,
                  title: 'M',
                  color: Colors.green,
                  // rows: 3,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                ClockColumn(
                  binaryInteger: _now.minuteOnes,
                  title: 'm',
                  color: Colors.lightGreen,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                ClockColumn(
                  binaryInteger: _now.secondTens,
                  title: 'S',
                  color: Colors.blue,
                  // rows: 2,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                ClockColumn(
                  binaryInteger: _now.secondOnes,
                  title: 's',
                  color: Colors.lightBlue[300],
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ClockColumn extends StatelessWidget {
  String binaryInteger;
  String title;
  Color color;
  int rows;
  double width;
  double height;
  List bits;

  ClockColumn(
      {this.binaryInteger,
      this.title,
      this.color,
      this.rows = 4,
      this.width,
      this.height}) {
    bits = binaryInteger.split('');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...[
          Container(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: height * 0.060, fontWeight: FontWeight.w200),
            ),
          )
        ],
        ...bits.asMap().entries.map((entry) {
          int idx = entry.key;
          String bit = entry.value;

          bool isActive = bit == '1';
          int binaryCellValue = pow(2, 3 - idx);

          return AnimatedContainer(
            duration: Duration(milliseconds: 475),
            curve: Curves.ease,
            height: height * 0.079,
            width: width * 0.079,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(width * 0.05)),
              color: isActive
                  ? color
                  : idx < 4 - rows
                      ? Colors.white.withOpacity(0.4)
                      : Colors.black38,
            ),
            margin: EdgeInsets.all(width * 0.01),
            child: Center(
              child: isActive
                  ? Text(
                      binaryCellValue.toString(),
                      style: TextStyle(
                        color: Colors.black38.withOpacity(0.4),
                        fontSize: height * 0.05,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Container(),
            ),
          );
        }),
        ...[
          Text(
            int.parse(binaryInteger, radix: 2).toString(),
            style: TextStyle(
              fontSize: height * 0.07,
              color: color,
            ),
          ),
          Container(
              child: Text(binaryInteger,
                  style: TextStyle(
                    fontSize: height * 0.03,
                    color: color,
                    fontWeight: FontWeight.w700,
                  )))
        ],
      ],
    );
  }
}
