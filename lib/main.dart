import 'dart:html';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';

void main() {
  runApp(const MaterialApp(
home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userQuestion = 'question';
  var userAnswer = 'answer';
  final Textstyles = TextStyle(fontSize: 29);


  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Column(
          children: [


            Expanded(child:
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer),
                  ),
                ],
              ),
            )),
            Expanded(
              flex: 2,
              child: Container(

                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, index) {
                      //

                      if (index == 0) {
                        return Mybutton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.yellowAccent,
                          textColor: Colors.black,

                        );
                        //deletebutton
                      } else if (index == 1) {
                        return Mybutton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red,
                          textColor: Colors.blue,

                        );
                      }
                      else if (index == buttons.length - 1) {
                        return Mybutton(
                          buttonTapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red,
                          textColor: Colors.blue,

                        );
                      } else {
                        return Mybutton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperating(buttons[index])
                              ? Colors.white
                              : Colors.yellowAccent,
                          textColor: isOperating(buttons[index])
                              ? Colors.black
                              : Colors.black,

                        );
                      }
                    },)
              ),

              // color: Colors.pink,
              //     child: Center(
              //       child: Mybutton(buttonText: "9", color: Colors.greenAccent, textColor: Colors.blueAccent ,),
              //     ),
            ),
          ],
        )
    );
  }


  bool isOperating(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }

}