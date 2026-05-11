import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool generalNotification = true;
  bool sound = false;
  bool vibrate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
            child: Text(
              "Common Settings",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.tealAccent,
              ),
            ),
          ),
          _buildSwitchTile(
            title: "General Notifications",
            value: generalNotification,
            onChanged: (val) => setState(() => generalNotification = val),
          ),
          _buildSwitchTile(
            title: "Sound",
            value: sound,
            onChanged: (val) => setState(() => sound = val),
          ),
          _buildSwitchTile(
            title: "Vibration",
            value: vibrate,
            onChanged: (val) => setState(() => vibrate = val),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      value: value,
      activeTrackColor: Colors.tealAccent,
      inactiveTrackColor: Colors.grey.shade700,
      onChanged: onChanged,
    );
  }
}
