import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _input = "";
  String _input1 = "";
  String _input2 = "";
  String _operation = "";
  double _num1 = 0;
  double _num2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 24, 24, 24),
                Color.fromARGB(255, 24, 24, 24),
              ],
            ),
          ),
          child: Column(
            children: [
              HeaderCard(
                input1: _input1,
                input2: _input2,
                num1: _num1.toString(),
                operation: _operation,
                num2: _num2.toString(),
                output: _output,
              ),
              CalButton(
                buttonPressed: buttonPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _input1 = "";
        _input2 = "";
        _output = "0";
        _num1 = 0.0;
        _num2 = 0.0;
        _operation = "";
        _input = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "/" ||
          buttonText == "x") {
        if (_input.isNotEmpty) {
          _input1 = _input;
          _num1 = double.parse(_input1);
          _operation = buttonText;
          _input = "";
        }
      } else if (buttonText == ".") {
        if (_input.contains(".")) {
          print("Already contains a decimal");
          return;
        } else {
          _input += buttonText;
        }
      } else if (buttonText == "=") {
        if (_input.isNotEmpty) {
          _input2 = _input;
          _num2 = double.parse(_input2);
          _input1 = "";
          _input2 = "";

          if (_operation == "+") {
            _output = (_num1 + _num2).toString();
          }
          if (_operation == "-") {
            _output = (_num1 - _num2).toString();
          }
          if (_operation == "x") {
            _output = (_num1 * _num2).toString();
          }
          if (_operation == "/") {
            _output = (_num1 / _num2).toString();
          }

          _num1 = 0.0;
          _num2 = 0.0;
          _operation = "";
          _input = _output;
        }
      } else {
        _input += buttonText;
      }

      print("Input: $_input");
      print("Output: $_output");
    });
  }
}

class HeaderCard extends StatelessWidget {
  final String input1;
  final String input2;
  final String num1;
  final String operation;
  final String num2;
  final String output;

  HeaderCard({
    required this.input1,
    required this.input2,
    required this.num1,
    required this.operation,
    required this.num2,
    required this.output,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Card(
        color: Colors.white,
        elevation: 14,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Input: $input1 $operation $input2",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Output: $output",
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalButton extends StatelessWidget {
  final Function(String) buttonPressed;

  CalButton({required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              buildButton("C", color: Colors.grey),
              buildButton("*", icon: Icons.clear, color: Colors.grey),
              buildButton("%", color: Colors.grey),
              buildButton("/", color: Colors.grey),
            ],
          ),
          Row(
            children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("x", color: Colors.grey),
            ],
          ),
          Row(
            children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("-", color: Colors.grey),
            ],
          ),
          Row(
            children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("+", color: Colors.grey),
            ],
          ),
          Row(
            children: [
              buildButton("+/-"),
              buildButton("0"),
              buildButton("."),
              buildButton("=", color: Colors.deepOrange),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, {IconData? icon, Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(24.0),
            side: const BorderSide(color: Colors.black),
            backgroundColor: color ?? Colors.black,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: icon == null
              ? Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              : Icon(
                  icon,
                  size: 24.0,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
