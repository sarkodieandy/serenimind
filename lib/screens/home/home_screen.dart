import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:serenimind/providers/session_provider.dart';
import 'package:serenimind/widgets/category_card.dart';
import 'package:serenimind/widgets/session_card.dart';

import '../../routes/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);
    final recommendedSessions = sessionProvider.getRecommendedSessions();
    final recentlyPlayed = sessionProvider.getRecentlyPlayed();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Moments'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today for you',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Featured session
            SessionCard(
              session: recommendedSessions.first,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.sessionDetail,
                  arguments: recommendedSessions.first.id,
                );
              },
              isFeatured: true,
            ),
            const SizedBox(height: 32),
            Text(
              'Categories',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                CategoryCard(
                  title: 'Meditation',
                  icon: Icons.self_improvement,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.category,
                      arguments: 'meditation',
                    );
                  },
                ),
                CategoryCard(
                  title: 'Sleep',
                  icon: Icons.nightlight_round,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.category,
                      arguments: 'sleep',
                    );
                  },
                ),
                CategoryCard(
                  title: 'Stress Relief',
                  icon: Icons.favorite,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.category,
                      arguments: 'stress',
                    );
                  },
                ),
                CategoryCard(
                  title: 'Anxiety',
                  icon: Icons.psychology,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.category,
                      arguments: 'anxiety',
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Recently Played',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recentlyPlayed.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 160,
                    child: SessionCard(
                      session: recentlyPlayed[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouter.sessionDetail,
                          arguments: recentlyPlayed[index].id,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 3) {
            Navigator.pushNamed(context, AppRouter.profile);
          }
        },
      ),
    );
  }
}
