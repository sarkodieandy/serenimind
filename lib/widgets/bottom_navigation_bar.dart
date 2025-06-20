import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:serenimind/screens/home/home_screen.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ExploreScreen(),
    JourneyScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2C2C2E),
        selectedItemColor: const Color(0xFF9C7BFF),
        unselectedItemColor: Colors.white60,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedHome01),
            activeIcon: Icon(HugeIcons.strokeRoundedHome01),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedLibraries),
            activeIcon: Icon(HugeIcons.strokeRoundedLibraries),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedCompass),
            activeIcon: Icon(HugeIcons.strokeRoundedCompass),
            label: 'Journey',
          ),
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedSetting06),
            activeIcon: Icon(HugeIcons.strokeRoundedSetting06),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Dummy Screens for demonstration
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Home', style: TextStyle(color: Colors.white, fontSize: 20)),
//     );
//   }
// }


class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Explore',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Journey',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Settings',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
