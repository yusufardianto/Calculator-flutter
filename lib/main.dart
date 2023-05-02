import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  // String equationFontSize = "";

  buttonPressed(String btntxt) {
    setState(() {
      if (btntxt == 'AC') {
        equation = "0";
        result = '0';
      } else if (btntxt == '<=') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '';
        }
      } else if (btntxt == '+/-') {
        equation = '-$equation';
      } else if (btntxt == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('%', '/100');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          // ignore: unrelated_type_equality_checks
          if (result.endsWith('.0')) {
            result = result.substring(0, result.length - 2);
          }
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == '0') {
          equation = btntxt;
        } else {
          equation = equation + btntxt;
        }
      }
    });
  }

  Widget buttoncalcu(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () => buttonPressed(btntxt),

      // ignore: sort_child_properties_last
      child: Text(
        btntxt,
        style: TextStyle(
          fontSize: 30,
          color: txtcolor,
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(btncolor),
          shape: const MaterialStatePropertyAll(CircleBorder()),
          fixedSize: const MaterialStatePropertyAll(Size(70, 70))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    equation,
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.grey, fontSize: 30),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    result,
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white, fontSize: 60),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttoncalcu('AC', Colors.grey[900]!, Colors.red),
                buttoncalcu('%', Colors.grey[900]!, Colors.green),
                buttoncalcu('<=', Colors.grey[900]!, Colors.green),
                buttoncalcu('/', Colors.grey[900]!, Colors.green),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttoncalcu('7', Colors.grey[900]!, Colors.white),
                buttoncalcu('8', Colors.grey[900]!, Colors.white),
                buttoncalcu('9', Colors.grey[900]!, Colors.white),
                buttoncalcu('x', Colors.grey[900]!, Colors.green),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttoncalcu('4', Colors.grey[900]!, Colors.white),
                buttoncalcu('5', Colors.grey[900]!, Colors.white),
                buttoncalcu('6', Colors.grey[900]!, Colors.white),
                buttoncalcu('-', Colors.grey[900]!, Colors.green),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttoncalcu('1', Colors.grey[900]!, Colors.white),
                buttoncalcu('2', Colors.grey[900]!, Colors.white),
                buttoncalcu('3', Colors.grey[900]!, Colors.white),
                buttoncalcu('+', Colors.grey[900]!, Colors.green),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttoncalcu('+/-', Colors.grey[900]!, Colors.white),
                buttoncalcu('0', Colors.grey[900]!, Colors.white),
                buttoncalcu('.', Colors.grey[900]!, Colors.white),
                buttoncalcu('=', Colors.green, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}
