import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:vibration/vibration.dart';

class TasbeehCounter extends StatefulWidget {
  @override
  _TasbeehCounterState createState() => _TasbeehCounterState();
}

class _TasbeehCounterState extends State<TasbeehCounter> {
  int count = 0;
  int targetCount = 33;
  bool vibrationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.mainColor,
        title: Text('Tasbeeh Counter',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    _restartCounter();
                  },
                ),
                IconButton(
                  icon: Icon(
                    vibrationEnabled ? Icons.vibration : Icons.mobile_off,
                  ),
                  onPressed: () {
                    _toggleVibration();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    _showSettingsDialog();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _incrementCounter();
                _vibrate();
              },
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CustomColors.mainColor,
                    width: 8,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$count',
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Target: $targetCount', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      count++;
      if (count >= targetCount) {
        count = 0;
      }
    });
  }

  void _vibrate() {
    if (vibrationEnabled) {
      HapticFeedback.vibrate();
    }
  }

  void _restartCounter() {
    setState(() {
      count = 0;
    });
  }

  void _toggleVibration() {
    setState(() {
      vibrationEnabled = !vibrationEnabled;
    });
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Target Count'),
          content: Column(
            children: [
              _buildTargetOption(33),
              _buildTargetOption(100),
              _buildTargetOption(1000),
              _buildCustomTargetOption(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTargetOption(int value) {
    return ListTile(
      title: Text('$value'),
      onTap: () {
        setState(() {
          targetCount = value;
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildCustomTargetOption() {
    TextEditingController customController = TextEditingController();
    return Column(
      children: [
        ListTile(
          title: TextField(
            controller: customController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Update the targetCount as the user enters a custom value
              int customValue = int.tryParse(value) ?? 0;
              setState(() {
                targetCount = customValue;
              });
            },
            decoration: InputDecoration(labelText: 'Custom'),
          ),
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
