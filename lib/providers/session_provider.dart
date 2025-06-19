import 'package:flutter/material.dart';

import '../models/meditation_session.dart';

class SessionProvider with ChangeNotifier {
  // Sample data - in a real app, this would come from an API
  final List<MeditationSession> _sessions = [
    MeditationSession(
      id: '1',
      title: 'Morning Calm',
      description: 'Start your day with peace and clarity',
      category: 'meditation',
      imageUrl: 'assets/images/morning_meditation.jpg',
      audioUrl: 'assets/audio/morning_meditation.mp3',
      duration: const Duration(minutes: 10),
      difficulty: 'Beginner',
    ),
    MeditationSession(
      id: '2',
      title: 'Deep Sleep',
      description: 'Fall asleep faster with this guided session',
      category: 'sleep',
      imageUrl: 'assets/images/sleep_meditation.jpg',
      audioUrl: 'assets/audio/sleep_meditation.mp3',
      duration: const Duration(minutes: 20),
      difficulty: 'All Levels',
    ),
    MeditationSession(
      id: '3',
      title: 'Stress Relief',
      description: 'Release tension and find your center',
      category: 'stress',
      imageUrl: 'assets/images/stress_relief.jpg',
      audioUrl: 'assets/audio/stress_relief.mp3',
      duration: const Duration(minutes: 15),
      difficulty: 'Intermediate',
    ),
    MeditationSession(
      id: '4',
      title: 'Body Scan',
      description: 'Connect with your body and release tension',
      category: 'meditation',
      imageUrl: 'assets/images/body_scan.jpg',
      audioUrl: 'assets/audio/body_scan.mp3',
      duration: const Duration(minutes: 12),
      difficulty: 'Beginner',
    ),
    MeditationSession(
      id: '5',
      title: 'Anxiety Relief',
      description: 'Calm your mind during anxious moments',
      category: 'stress',
      imageUrl: 'assets/images/anxiety_relief.jpg',
      audioUrl: 'assets/audio/anxiety_relief.mp3',
      duration: const Duration(minutes: 8),
      difficulty: 'All Levels',
      isPremium: true,
    ),
  ];

  final List<String> _favorites = [];
  MeditationSession? _currentSession;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;

  List<MeditationSession> get sessions => _sessions;
  List<String> get favorites => _favorites;
  MeditationSession? get currentSession => _currentSession;
  bool get isPlaying => _isPlaying;
  Duration get currentPosition => _currentPosition;

  List<MeditationSession> getRecommendedSessions() {
    return _sessions.take(3).toList();
  }

  List<MeditationSession> getSessionsByCategory(String category) {
    return _sessions.where((session) => session.category == category).toList();
  }

  List<MeditationSession> getRecentlyPlayed() {
    return _sessions.take(2).toList();
  }

  void toggleFavorite(String sessionId) {
    if (_favorites.contains(sessionId)) {
      _favorites.remove(sessionId);
    } else {
      _favorites.add(sessionId);
    }
    notifyListeners();
  }

  void setCurrentSession(String sessionId) {
    _currentSession = _sessions.firstWhere(
      (session) => session.id == sessionId,
    );
    notifyListeners();
  }

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void updatePosition(Duration position) {
    _currentPosition = position;
    notifyListeners();
  }

  void resetPlayer() {
    _isPlaying = false;
    _currentPosition = Duration.zero;
    notifyListeners();
  }
}
