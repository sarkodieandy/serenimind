import 'package:flutter/material.dart';

class AllSetScreen extends StatelessWidget {
  final VoidCallback? onComplete;

  const AllSetScreen({super.key, this.onComplete});

  void _goToHome() {
    if (onComplete != null) onComplete!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You're all set!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Reminders and notifications are ready.Start your journey to a calmer mind.",
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _goToHome,

                child: const Text("Start Meditating"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
