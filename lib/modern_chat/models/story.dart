class Story {
  final String id;
  final String userId;
  final List<StoryItem> items;
  final DateTime timestamp;
  final bool isViewed;

  Story({
    required this.id,
    required this.userId,
    required this.items,
    required this.timestamp,
    this.isViewed = false,
  });
}

class StoryItem {
  final String id;
  final String imageUrl;
  final DateTime timestamp;
  final bool isViewed;

  StoryItem({
    required this.id,
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
    items: [
      StoryItem(
        id: '1_1',
        imageUrl: 'https://picsum.photos/id/1015/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      StoryItem(
        id: '1_2',
        imageUrl: 'https://picsum.photos/id/1016/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      StoryItem(
        id: '1_3',
        imageUrl: 'https://picsum.photos/id/1018/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
    ],
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  Story(
    id: '2',
    userId: '2', // James Rodriguez
    items: [
      StoryItem(
        id: '2_1',
        imageUrl: 'https://picsum.photos/id/1019/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      StoryItem(
        id: '2_2',
        imageUrl: 'https://picsum.photos/id/1020/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 14)),
      ),
    ],
    timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
  ),
  // Add more stories...
]; 