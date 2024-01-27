import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  Color buttonColor = Colors.green;  // สีเริ่มต้น

  @override
  void initState() {
    super.initState();
    // เรียกใช้ฟังก์ชันสำหรับสุ่มสีที่จะกำหนดให้กับปุ่ม
    generateRandomColor();
  }

  void generateRandomColor() {
    // สุ่มเลือกสีใหม่
    final Random random = Random();
    final int red = random.nextInt(256);
    final int green = random.nextInt(256);
    final int blue = random.nextInt(256);

    // กำหนดสีใหม่ในรูปแบบ Color
    buttonColor = Color.fromARGB(255, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calculate),  // เพิ่มไอคอนเครื่องคิดเลข
            SizedBox(width: 8.0),
            Text('MY CALCULATOR'),
          ],
        ),
        centerTitle: true,
        
      ),

      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                displayText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                ),
              ),
            ),
          ),
          Row(
            children: [
              buildButton('C', Color.fromARGB(255, 199, 200, 201)),
              buildButton('⌫', Color.fromARGB(255, 199, 200, 201)),             
            ],
          ),
          Row(
            children: [
              buildButton('7', buttonColor),
              buildButton('8', buttonColor),
              buildButton('9', buttonColor),
              buildButton('÷', Color.fromARGB(255, 199, 200, 201)),
            ],
          ),
          Row(
            children: [
              buildButton('4', buttonColor),
              buildButton('5', buttonColor),
              buildButton('6', buttonColor),
              buildButton('x', Color.fromARGB(255, 199, 200, 201)),
            ],
          ),
          Row(
            children: [
              buildButton('1', buttonColor),
              buildButton('2', buttonColor),
              buildButton('3', buttonColor),
              buildButton('-', Color.fromARGB(255, 199, 200, 201)),
            ],
          ),
          Row(
            children: [
              // ปรับ flex ของปุ่ม 0 เพื่อให้มีขนาดใหญ่ขึ้น
              buildButton('0', buttonColor, flex: 3),  
              buildButton('+', Color.fromARGB(255, 199, 200, 201)),
            ],
          ),
          Row(
            children: [
              buildButton('=', Colors.blue, flex: 4),  // ปรับ flex ของปุ่ม = เพื่อให้มีขนาดใหญ่ขึ้น
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text, Color color, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: ElevatedButton(
            onPressed: () => onButtonPressed(text),
            style: ElevatedButton.styleFrom(
              primary: color,
              padding: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }


  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C' || buttonText == '=') {
        displayText = '0';
      } else if (buttonText == '⌫') {
        if (displayText.length > 1) {
          displayText = displayText.substring(0, displayText.length - 1);
        } else {
          displayText = '0';
        }
      } else {
        if (isOperator(displayText[displayText.length - 1]) &&
            isOperator(buttonText)) {
          displayText = displayText.substring(0, displayText.length - 1);
        }
        displayText += buttonText;
      }
    });
  }
}
bool isOperator(String value) {
  return ['+', '-', 'x', '/'].contains(value);
}
