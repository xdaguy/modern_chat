class Story {
  final String id;
  final String userId;
  final String imageUrl;
  final DateTime timestamp;
  final bool isViewed;

  Story({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.timestamp,
    this.isViewed = false,
  });
}

// Sample stories data
final List<Story> sampleStories = [
  Story(
    id: '1',
    userId: '1', // Emma Watson
    imageUrl: 'https://picsum.photos/id/1015/800/1200',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  Story(
    id: '2',
    userId: '2', // James Rodriguez
    imageUrl: 'https://picsum.photos/id/1016/800/1200',
    timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
  ),
  // Add more stories...
]; 