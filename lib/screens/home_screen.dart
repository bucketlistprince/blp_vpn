import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/vpn_button.dart'; // Import the button widget
import '../widgets/dropdowns_widget.dart'; // Import the new dropdowns widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = false;
  String? selectedServer;
  String? selectedPayload;
  List<String> servers = ['Server 1', 'Server 2', 'Server 3'];
  List<String> payloads = ['Payload 1', 'Payload 2', 'Payload 3'];

  Duration _connectionDuration = Duration(minutes: 15);
  Timer? _timer;
  DateTime _startTime = DateTime.now();
  Duration _remainingTime = Duration.zero;
  List<String> _logs = [];
  String uploadSpeed = "0 KB/s";  // Example initial speed
  String downloadSpeed = "0 KB/s"; // Example initial speed

  void _toggleConnection() {
    setState(() {
      isConnected = !isConnected;
      if (isConnected) {
        _startCountdown();
        _addLog('Connecting...');
        // Simulate a connection success after a short delay
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _addLog('Connected');
          });
        });
      } else {
        _stopCountdown();
        _addLog('Disconnected');
      }
    });
  }

  void _startCountdown() {
    _startTime = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        final elapsedTime = DateTime.now().difference(_startTime);
        _remainingTime = _connectionDuration - elapsedTime;
        if (_remainingTime.isNegative) {
          _remainingTime = Duration.zero;
          _stopCountdown();
          isConnected = false;
          _addLog('Disconnected (Session Ended)');
        }
      });
    });
  }

  void _stopCountdown() {
    _timer?.cancel();
    _timer = null;
  }

  String get _formattedDuration {
    final int hours = _remainingTime.inHours;
    final int minutes = _remainingTime.inMinutes % 60;
    final int seconds = _remainingTime.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _addLog(String message) {
    setState(() {
      _logs.add(message);
    });
  }

  void _showLogs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logs'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _logs.map((log) => Text(log)).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        title: const Text('VPN App'),
        backgroundColor: Colors.blueGrey[900], // Dark theme app bar
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Implement navigation to settings page or show a settings dialog
            },
            tooltip: 'Settings',
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              // Implement navigation to help & support page or show a help dialog
            },
            tooltip: 'Help & Support',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Center Section with Connect/Disconnect Button and Countdown
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      VPNButton(
                        isConnected: isConnected,
                        onPressed: _toggleConnection,
                        isConnecting: !isConnected && _timer != null,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _formattedDuration,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      // Use the DropdownsWidget here
                      DropdownsWidget(
                        selectedServer: selectedServer,
                        selectedPayload: selectedPayload,
                        servers: servers,
                        payloads: payloads,
                        onServerChanged: (String? newValue) {
                          setState(() {
                            selectedServer = newValue;
                          });
                        },
                        onPayloadChanged: (String? newValue) {
                          setState(() {
                            selectedPayload = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      // Upload and Download Speed Indicators
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.upload, color: Colors.white),
                            const SizedBox(width: 10),
                            Text(
                              uploadSpeed,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(width: 20),
                            const Icon(Icons.download, color: Colors.white),
                            const SizedBox(width: 10),
                            Text(
                              downloadSpeed,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Floating Action Button for Viewing Logs
          Positioned(
            bottom: 50,
            right: 30,
            child: FloatingActionButton(
              onPressed: _showLogs,
              backgroundColor: Colors.blueGrey[800],
              tooltip: 'Logs',
              child: const Icon(Icons.computer),
            ),
          ),
        ],
      ),
    );
  }
}
