import 'package:flutter/material.dart';
import 'package:currency_converter/helper/constants.dart';
import 'package:currency_converter/helper/helperfunctions.dart';
import 'package:flutter/services.dart';

class WhiteBackGround extends StatefulWidget {
  @override
  _WhiteBackGroundState createState() => _WhiteBackGroundState();
}

class _WhiteBackGroundState extends State<WhiteBackGround> {
  String output = "";
  int decimal = 0;

  addTextToTheOutput(String number) {
    setState(() {

      if(number == '.' && decimal == 0) {
        decimal++;
        output += number;
      } else if(number == '.' && decimal > 0) {
        print("Decimal is already there!");
      } else {
        output += number;
      }

    });
  }

  Widget numberButtons(String number) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.red[300],
        borderRadius: BorderRadius.circular(50)
      ),
      child: RawMaterialButton(
        onPressed: () {
          addTextToTheOutput(number);
        },
        child: Text(number, style: TextStyle(color: Colors.white, fontSize: 17),),
        shape: CircleBorder(),
      )
    );
  }

  Widget doneButton() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.red[300],
        borderRadius: BorderRadius.circular(50)
      ),
      child: RawMaterialButton(
        onPressed: () {
          setState(() {
            Constants.whiteCurrency = output;
            Constants.redCurrency = convWhiteToRed(output);
            print("Pressed");
          });

          // Saving the data
          HelperFunctions().saveRedCurrencyValue(Constants.redCurrency);
          HelperFunctions().saveWhiteCurrencyValue(Constants.whiteCurrency);
          print("saved");

          Navigator.pop(context);
        },
        child: Icon(Icons.check, color: Colors.white,),
        shape: CircleBorder(),
      )
    );
  }


  String convWhiteToRed(String currencyValue) {
    var factor = Constants.currencyJson[Constants.whiteCurr][Constants.redCurr];
    var value = double.parse(currencyValue);
    var calculatedValue = value * factor;
    return calculatedValue.toStringAsFixed(2);
  }




  // UI OF THE SCREEN
  @override
  Widget build(BuildContext context) {

    // Fixing the apps orientaion in Potrait Mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[ 
            /*1*/           
            Container(              
              height: 30,
              width: 180,
              child: RawMaterialButton(
                onPressed: () {
                  setState(() {
                    output = "";
                    decimal = 0;
                  });
                },
                child: Text("tap to delete", style: TextStyle(color: Colors.red[200]),),
              ),
            ),
            /*2*/
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width - 30,              
              child: Center(
                child: Text(
                  "$output", 
                  style: TextStyle(
                    fontSize: 40, 
                    color: Colors.red[200],
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
            /*3*/
            Container(
              height: MediaQuery.of(context).size.height / 2,              
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numberButtons("1"),
                      numberButtons("2"),
                      numberButtons("3")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numberButtons("4"),
                      numberButtons("5"),
                      numberButtons("6")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numberButtons("7"),
                      numberButtons("8"),
                      numberButtons("9")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numberButtons("."),
                      numberButtons("0"),
                      doneButton()
                    ],
                  ),
                  Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_downward, color: Colors.red[200],),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}