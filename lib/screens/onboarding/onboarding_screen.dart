import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:serenimind/routes/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      int nextPage = _currentPage + 1;
      if (nextPage >= onboardingPages.length) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> onboardingPages = [
    {
      'image': 'assets/images/onboarding1.svg',
      'subtitle': 'Find Peace Within',
      'description':
          'Discover guided meditations to calm your mind and reduce stress. Feel balanced, one breath at a time.',
    },
    {
      'image': 'assets/images/onboarding2.svg',
      'subtitle': 'Sleep Sounds & Stories',
      'description':
          'Fall asleep faster with soothing stories, calming music, and peaceful sounds. Let go of stress and rest deeply.',
    },
    {
      'image': 'assets/images/onboarding3.svg',
      'subtitle': "A Habit of Calm",

      'description':
          'Build a habit with short daily practices. Boost focus, reduce anxiety, and bring calm to your day.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                          vertical: size.height * 0.02,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo
                            Row(
                              children: [
                                Icon(Icons.waves, size: size.width * 0.07),
                                const SizedBox(width: 8),
                                Text(
                                  'Serenimind',
                                  style: TextStyle(
                                    fontSize: size.width * 0.055,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            DefaultTextStyle(
                              style: TextStyle(
                                color: Color(0xFF6C5CE7),
                                fontSize: size.width * 0.09,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FadeAnimatedText(
                                    'Breathe.',
                                    duration: Duration(seconds: 3),
                                  ),
                                  TypewriterAnimatedText(
                                    'Breathe. Relax.',
                                    speed: Duration(milliseconds: 100),
                                  ),
                                  FadeAnimatedText(
                                    'Breathe. Relax. Begin.',
                                    duration: Duration(seconds: 5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Carousel area
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: onboardingPages.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final page = onboardingPages[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.06,
                                vertical: size.height * 0.04,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      page['image']!,
                                      width: size.width,
                                      height: size.height * 0.25,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      page['subtitle']!,
                                      style: TextStyle(
                                        fontSize: size.width * 0.07,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      page['description']!,
                                      style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        height: 1.4,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Page indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingPages.length,
                          (index) => _dot(isActive: index == _currentPage),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Buttons
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                        ),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.signInSignUp,
                                );
                              },
                              child: const Text(
                                'Sign in or Sign up',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: () {
                                // TODO
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6C5CE7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _dot({bool isActive = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color:
            isActive
                ? Color(0xFF6C5CE7)
                : const Color.fromARGB(60, 105, 105, 105),
        shape: BoxShape.circle,
      ),
    );
  }
}
