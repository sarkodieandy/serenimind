import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:serenimind/providers/session_provider.dart';
import 'package:serenimind/widgets/stat_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile header
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Alex Johnson',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Beginner Meditator',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Stats
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                StatCard(
                  value: '12',
                  label: 'Current Streak',
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
                StatCard(
                  value: '24',
                  label: 'Total Hours',
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
                StatCard(
                  value: '87',
                  label: 'Sessions',
                  icon: Icons.self_improvement,
                  color: Colors.purple,
                ),
                StatCard(
                  value: '4.8',
                  label: 'Avg. Rating',
                  icon: Icons.star,
                  color: Colors.yellow.shade700,
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Favorites section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Favorites',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            if (sessionProvider.favorites.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No favorites yet',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the heart icon on any session to add it here',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sessionProvider.favorites.length,
                itemBuilder: (context, index) {
                  final sessionId = sessionProvider.favorites[index];
                  final session = sessionProvider.sessions.firstWhere(
                    (s) => s.id == sessionId,
                  );
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        session.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(session.title),
                    subtitle: Text('${session.duration.inMinutes} min'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        sessionProvider.toggleFavorite(sessionId);
                      },
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/session-detail',
                        arguments: sessionId,
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
