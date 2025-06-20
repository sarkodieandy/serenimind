import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  final VoidCallback? onComplete;

  const NotificationsScreen({super.key, this.onComplete});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _notificationGranted = false;
  TimeOfDay? _reminderTime;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.notification.status;
    setState(() {
      _notificationGranted = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    final result = await Permission.notification.request();
    setState(() {
      _notificationGranted = result.isGranted;
    });
  }
Future<void> _pickReminderTime() async {
  final alarmStatus = await Permission.scheduleExactAlarm.status;

  // If not granted, show a SnackBar prompting user to allow
  if (!alarmStatus.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Alarm permission is needed to set a reminder."),
        action: SnackBarAction(
          label: "Allow",
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () async {
            final newStatus = await Permission.scheduleExactAlarm.request();
            if (newStatus.isGranted) {
              _showTimePicker();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Permission denied.")),
              );
            }
          },
        ),
      ),
    );
    return;
  }

  // If already granted, show time picker directly
  _showTimePicker();
}

void _showTimePicker() async {
  final now = TimeOfDay.now();
  final picked = await showTimePicker(context: context, initialTime: now);

  if (picked != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('reminder_hour', picked.hour);
    await prefs.setInt('reminder_minute', picked.minute);
    setState(() => _reminderTime = picked);
  }
}


  void _completeSetup() {
    if (widget.onComplete != null) widget.onComplete!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Stay Mindful with Reminders",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _notificationGranted
                        ? "Now, set a daily reminder time to help you stay on track."
                        : "We'd like to send you notifications to help you stay mindful.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  if (!_notificationGranted)
                    ElevatedButton(
                      onPressed: _requestPermission,
                      child: Text("Allow Notifications"),
                    )
                  else if (_reminderTime == null)
                    ElevatedButton(
                      onPressed: _pickReminderTime,
                      child: Text("Set Daily Reminder"),
                    )
                  else
                    ElevatedButton(
                      onPressed: _completeSetup,
                      child: Text(_reminderTime!.format(context)),
                    ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _completeSetup,
                    child: Text("Skip for now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
