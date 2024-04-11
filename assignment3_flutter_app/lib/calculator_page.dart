// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<Calculator> {
  late String _expression = '';
  late String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter a mathematical expression',
              ),
              onChanged: (value) {
                setState(() {
                  _expression = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _evaluateExpression();
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  void _evaluateExpression() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _result = eval.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: Calculator(),
  ));
}
