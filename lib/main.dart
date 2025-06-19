import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenimind/app.dart';
import 'package:serenimind/providers/session_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SessionProvider())],
      child: const MindfulnessApp(),
    ),
  );
}
