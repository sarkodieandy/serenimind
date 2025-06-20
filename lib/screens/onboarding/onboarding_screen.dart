import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:serenimind/screens/onboarding/all_set_screen.dart';
import 'package:serenimind/screens/onboarding/notifications_screen.dart';
import 'package:serenimind/widgets/bottom_navigation_bar.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<Widget> _pages = [];
  final List<String> _images = [
    'assets/images/notification.svg',
    'assets/images/allset.svg',
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      NotificationsScreen(
        onComplete: () {
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        },
      ),
      AllSetScreen(
        onComplete:
            () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BottomNavigationBarView(),
              ),
            ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Visibility(
              visible:
                  MediaQuery.of(context).size.height > 500 &&
                  MediaQuery.of(context).orientation == Orientation.portrait,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: SvgPicture.asset(
                    _images[_currentPage],
                    key: ValueKey<String>(_images[_currentPage]),
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) => _pages[index],
              ),
            ),
            pageIndicator(
              currentIndex: _currentPage,
              totalSteps: _pages.length,
            ),
          ],
        ),
      ),
    );
    
  }
 
  Widget pageIndicator(
    {required int currentIndex,
  required int totalSteps,}

 
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (index) {
          return Container(
            width: index == currentIndex? 12 : 8,
            height: index == currentIndex? 12 : 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentIndex
                  ? Color(0xFF6C5CE7)
                : const Color.fromARGB(60, 105, 105, 105),
            ),
          );
        }),
      ),
    );
  }


  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
