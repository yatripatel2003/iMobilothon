import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlertScreen(),
    );
  }
}

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  String _alertMessage = "Waiting for alerts...";

  @override
  void initState() {
    super.initState();
    _getAlert();
  }

  // Fetch alert data from cloud server
  Future<void> _getAlert() async {
    final response = await http.get(Uri.parse('http://your_server_ip:5000/alerts'));
    if (response.statusCode == 200) {
      setState(() {
        _alertMessage = json.decode(response.body)['message'];
      });
    } else {
      setState(() {
        _alertMessage = "Failed to load alert.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vehicle Safety System")),
      body: Center(
        child: Text(_alertMessage, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
