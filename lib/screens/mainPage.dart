import 'package:currency_converter/screens/redTyper.dart';
import 'package:currency_converter/screens/whiteTyper.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  bool up = true;

  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 1.5
  );
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                // The Red Container
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.red,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          "Dollar",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontSize: 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      child: RedBackGround(),
                                      type: PageTransitionType.upToDown,
                                      duration: Duration(milliseconds: 200))),
                              child: Text("100",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Quicksand',
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text("\$",
                                style: TextStyle(
                                    color: Colors.red[200],
                                    fontSize: 40,
                                    fontWeight: FontWeight.w300))
                          ],
                        ),
                        Text("USD",
                            style: TextStyle(
                                color: Colors.red[200],
                                fontFamily: 'Quicksand',
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 1,
                        )
                      ],
                    ),
                  ),
                ),
                // The White Container
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        Text("USD",
                            style: TextStyle(
                                color: Colors.red[200],
                                fontFamily: 'Quicksand',
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  PageTransition(
                                    child: WhiteBackGround(),
                                    type: PageTransitionType.downToUp,
                                    duration: Duration(milliseconds: 200)
                                  )),
                              child: Text("100",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Quicksand',
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text("\$",
                                style: TextStyle(
                                    color: Colors.red[200],
                                    fontSize: 40,
                                    fontWeight: FontWeight.w300))
                          ],
                        ),
                        Text(
                          "Dollar",
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Quicksand',
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            // The Arrow Container
            RotationTransition(
              turns: turnsTween.animate(_animationController),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if(up) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                    up = !up;
                  });                  
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red, width: 10),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.red,
                      size: 90,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
