// lib/widgets/dropdowns_widget.dart
import 'package:flutter/material.dart';

class DropdownsWidget extends StatelessWidget {
  final String? selectedServer;
  final String? selectedPayload;
  final List<String> servers;
  final List<String> payloads;
  final ValueChanged<String?> onServerChanged;
  final ValueChanged<String?> onPayloadChanged;

  const DropdownsWidget({
    Key? key,
    required this.selectedServer,
    required this.selectedPayload,
    required this.servers,
    required this.payloads,
    required this.onServerChanged,
    required this.onPayloadChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity, // Make dropdown stretch the full width
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[800], // Background color of dropdown
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedServer,
                items: servers.map((String server) {
                  return DropdownMenuItem<String>(
                    value: server,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        server,
                        style: TextStyle(color: Colors.white), // Text color
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onServerChanged,
                // Customize the style to hide the dropdown arrow
                icon: const SizedBox.shrink(), // Hide the arrow
                dropdownColor: Colors.blueGrey[800], // Dropdown menu background color
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity, // Make dropdown stretch the full width
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[800], // Background color of dropdown
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPayload,
                items: payloads.map((String payload) {
                  return DropdownMenuItem<String>(
                    value: payload,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        payload,
                        style: TextStyle(color: Colors.white), // Text color
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onPayloadChanged,
                // Customize the style to hide the dropdown arrow
                icon: const SizedBox.shrink(), // Hide the arrow
                dropdownColor: Colors.blueGrey[800], // Dropdown menu background color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
