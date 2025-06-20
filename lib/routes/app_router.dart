import 'package:flutter/material.dart';
import 'package:serenimind/screens/audio_player/audio_player_screen.dart';
import 'package:serenimind/screens/category/category_screen.dart';
import 'package:serenimind/screens/home/home_screen.dart';
import 'package:serenimind/screens/onboarding/onboarding_screen.dart';
import 'package:serenimind/screens/profile/profile_screen.dart';
import 'package:serenimind/screens/session_detail/session_detail.dart';
import 'package:serenimind/screens/auth/sign_in_sign_up_screen.dart';

class AppRouter {
  static const String onboarding = '/';
  static const String home = '/home';
  static const String category = '/category';
  static const String sessionDetail = '/session-detail';
  static const String audioPlayer = '/audio-player';
  static const String profile = '/profile';
  static const String signInSignUp = '/sign-in-sign-up';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return _slideRoute(OnboardingScreen(), settings);
      case signInSignUp:
        return _slideRoute(const SignInSignUpScreen(), settings);
      case home:
        return _slideRoute(HomeScreen(), settings);
      case category:
        return _slideRoute(
          CategoryScreen(category: settings.arguments as String),
          settings,
        );
      case sessionDetail:
        return _fadeRoute(
          SessionDetailScreen(sessionId: settings.arguments as String),
          settings,
        );
      case audioPlayer:
        return _fadeRoute(const AudioPlayerScreen(), settings);
      case profile:
        return _slideRoute(const ProfileScreen(), settings);
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }

  static PageRouteBuilder _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
