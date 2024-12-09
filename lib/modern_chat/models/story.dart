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
  Story(
    id: '3',
    userId: '3', // Sophia Chen
    items: [
      StoryItem(
        id: '3_1',
        imageUrl: 'https://picsum.photos/id/1021/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      StoryItem(
        id: '3_2',
        imageUrl: 'https://picsum.photos/id/1022/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 29)),
      ),
      StoryItem(
        id: '3_3',
        imageUrl: 'https://picsum.photos/id/1023/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
      ),
      StoryItem(
        id: '3_4',
        imageUrl: 'https://picsum.photos/id/1024/800/1200',
        timestamp: DateTime.now().subtract(const Duration(minutes: 27)),
      ),
    ],
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  Story(
    id: '4',
    userId: '4', // Marcus Johnson
    items: [
      StoryItem(
        id: '4_1',
        imageUrl: 'https://picsum.photos/id/1025/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      StoryItem(
        id: '4_2',
        imageUrl: 'https://picsum.photos/id/1026/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
      ),
    ],
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Story(
    id: '5',
    userId: '5', // Isabella Martinez
    items: [
      StoryItem(
        id: '5_1',
        imageUrl: 'https://picsum.photos/id/1027/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      StoryItem(
        id: '5_2',
        imageUrl: 'https://picsum.photos/id/1028/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 50)),
      ),
      StoryItem(
        id: '5_3',
        imageUrl: 'https://picsum.photos/id/1029/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 45)),
      ),
    ],
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  Story(
    id: '6',
    userId: '6', // Alexander White
    items: [
      StoryItem(
        id: '6_1',
        imageUrl: 'https://picsum.photos/id/1030/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      StoryItem(
        id: '6_2',
        imageUrl: 'https://picsum.photos/id/1031/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 4, minutes: 55)),
      ),
      StoryItem(
        id: '6_3',
        imageUrl: 'https://picsum.photos/id/1032/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 4, minutes: 50)),
      ),
    ],
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  Story(
    id: '7',
    userId: '7', // Olivia Brown
    items: [
      StoryItem(
        id: '7_1',
        imageUrl: 'https://picsum.photos/id/1033/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      StoryItem(
        id: '7_2',
        imageUrl: 'https://picsum.photos/id/1034/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 7, minutes: 55)),
      ),
    ],
    timestamp: DateTime.now().subtract(const Duration(hours: 8)),
  ),
  Story(
    id: '8',
    userId: '8', // Daniel Lee
    items: [
      StoryItem(
        id: '8_1',
        imageUrl: 'https://picsum.photos/id/1035/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 10)),
      ),
      StoryItem(
        id: '8_2',
        imageUrl: 'https://picsum.photos/id/1036/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 9, minutes: 55)),
      ),
      StoryItem(
        id: '8_3',
        imageUrl: 'https://picsum.photos/id/1037/800/1200',
        timestamp: DateTime.now().subtract(const Duration(hours: 9, minutes: 50)),
      ),
    ],
    timestamp: DateTime.now().subtract(const Duration(hours: 10)),
  ),
]; 