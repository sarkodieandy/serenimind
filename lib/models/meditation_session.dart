class MeditationSession {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String audioUrl;
  final Duration duration;
  final String difficulty;
  final bool isPremium;

  const MeditationSession({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.audioUrl,
    required this.duration,
    required this.difficulty,
    this.isPremium = false,
  });
}
