import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "Flutter Demo Home Page"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 色の定義
  static const Color colorMain = Colors.black;
  static const Color colorNum = Colors.white10;
  static const Color colorFunc = Colors.white54;
  static const Color colorCalc = Colors.orange;
  static const Color colorText = Colors.white;

  String txtReult = "0";
  double currentValue = 0;
  double previousValue = 0;

  String result = "";
  String finalResult = "";
  String opr = "";
  String preOpr = "";

  Widget btn(String btnText, Color colorButton, Color colorText) {
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          child: Padding(
            padding: btnText == "0"
                ? EdgeInsets.only(left: 20, top: 20, right: 120, bottom: 20)
                : btnText.length == 1
                    ? EdgeInsets.all(22)
                    : EdgeInsets.symmetric(horizontal: 15, vertical: 22),
            child: Text(
              btnText,
              style: TextStyle(fontSize: 30),
            ),
          ),
          onPressed: () {
            calculation(btnText);
          },
          style: ElevatedButton.styleFrom(
            primary: colorButton,
            onPrimary: colorText,
            shape: btnText == "0" ? StadiumBorder() : CircleBorder(),
          ),
        ));
  } // end of button

  Widget build(BuildContext buildCx) {
    return Scaffold(
      backgroundColor: colorMain,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    txtReult,
                    style: TextStyle(
                      color: colorText,
                      fontSize: 60,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn("C", colorFunc, colorMain),
                btn("+/-", colorFunc, colorMain),
                btn("%", colorFunc, colorMain),
                btn("/", colorCalc, colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn("7", colorNum, colorText),
                btn("8", colorNum, colorText),
                btn("9", colorNum, colorText),
                btn("x", colorCalc, colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn("4", colorNum, colorText),
                btn("5", colorNum, colorText),
                btn("6", colorNum, colorText),
                btn("-", colorCalc, colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn("1", colorNum, colorText),
                btn("2", colorNum, colorText),
                btn("3", colorNum, colorText),
                btn("+", colorCalc, colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn("0", colorNum, colorText),
                btn(".", colorNum, colorText),
                btn("=", colorCalc, colorText),
              ],
            ),
          ],
        ),
      ),
    );
  } // end of state class

  void calculation(String btnText) {
    if (btnText == "C") {
      txtReult = "0";
      currentValue = 0;
      previousValue = 0;
      result = "";
      finalResult = "";
      opr = "";
      preOpr = "";
    } else if (opr == "=" && btnText == "=") {
      if (preOpr == "+") {
        finalResult = add();
      } else if (preOpr == "-") {
        finalResult = sub();
      } else if (preOpr == "x") {
        finalResult = mul();
      } else if (preOpr == "/") {
        finalResult = div();
      }
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "x" ||
        btnText == "/" ||
        btnText == "=") {
      if (currentValue == 0) {
        currentValue = double.parse(result);
      } else {
        previousValue = double.parse(result);
      }

      if (opr == "+") {
        finalResult = add();
      } else if (opr == "-") {
        finalResult = sub();
      } else if (opr == "x") {
        finalResult = mul();
      } else if (opr == "/") {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = "";
    } else if (btnText == "%") {
      result = (currentValue / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == ".") {
      if (!result.toString().contains(".")) {
        result = result.toString() + ".";
      }
      finalResult = result;
    } else if (btnText == "+/-") {
      result.toString().startsWith("-")
          ? result = result.toString().substring(1)
          : result = "-" + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      txtReult = finalResult;
      print("currentValue: $currentValue  previousValue: $previousValue");
    });
  }

  String add() {
    result = (currentValue + previousValue).toString();
    currentValue = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (currentValue - previousValue).toString();
    currentValue = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (currentValue * previousValue).toString();
    currentValue = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (currentValue / previousValue).toString();
    currentValue = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains(".")) {
      List<String> splitDecimal = result.toString().split(".");
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
