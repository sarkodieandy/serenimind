import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:serenimind/providers/session_provider.dart';
import 'package:serenimind/routes/app_router.dart';
import 'package:serenimind/widgets/session_card.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  String getCategoryTitle() {
    switch (category) {
      case 'meditation':
        return 'Meditation';
      case 'sleep':
        return 'Sleep';
      case 'stress':
        return 'Stress Relief';
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);
    final sessions = sessionProvider.getSessionsByCategory(category);

    return Scaffold(
      appBar: AppBar(title: Text(getCategoryTitle())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            return SessionCard(
              session: sessions[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.sessionDetail,
                  arguments: sessions[index].id,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
