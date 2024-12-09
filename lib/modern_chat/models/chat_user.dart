/// Model class for chat users
class ChatUser {
  final String id;
  final String name;
  final String avatarUrl;
  final String coverUrl;
  final bool isOnline;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool isPinned;

  ChatUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.coverUrl,
    this.isOnline = false,
    this.lastMessage = '',
    this.lastMessageTime = '',
    this.unreadCount = 0,
    this.isPinned = false,
  });
}

// Sample users data
final List<ChatUser> sampleUsers = [
  ChatUser(
    id: '1',
    name: 'Emma Watson',
    avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
    isOnline: true,
    lastMessage: 'Hey! How are you doing?',
    lastMessageTime: '12:30',
    unreadCount: 2,
    isPinned: true,
  ),
  ChatUser(
    id: '2',
    name: 'James Rodriguez',
    avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&q=80',
    isOnline: false,
    lastMessage: 'Let\'s meet tomorrow',
    lastMessageTime: '11:45',
    unreadCount: 0,
    isPinned: true,
  ),
  ChatUser(
    id: '3',
    name: 'Sophia Chen',
    avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1498550744921-75f79806b8a7?w=800&q=80',
    isOnline: true,
    lastMessage: 'The project is done! 🎉',
    lastMessageTime: '10:18',
    unreadCount: 3,
    isPinned: true,
  ),
  ChatUser(
    id: '4',
    name: 'Marcus Johnson',
    avatarUrl: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=800&q=80',
    isOnline: true,
    lastMessage: 'Can you check the docs?',
    lastMessageTime: '09:30',
    unreadCount: 0,
    isPinned: true,
  ),
  ChatUser(
    id: '5',
    name: 'Isabella Martinez',
    avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1511300636408-a63a89df3482?w=800&q=80',
    isOnline: false,
    lastMessage: 'Great idea! 👍',
    lastMessageTime: '09:15',
    unreadCount: 0,
    isPinned: true,
  ),
  ChatUser(
    id: '6',
    name: 'Alexander White',
    avatarUrl: 'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1505144808419-1957a94ca61e?w=800&q=80',
    isOnline: true,
    lastMessage: 'When is the meeting?',
    lastMessageTime: 'Yesterday',
    unreadCount: 1,
  ),
  ChatUser(
    id: '7',
    name: 'Olivia Brown',
    avatarUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1502481851512-e9e2529bfbf9?w=800&q=80',
    isOnline: false,
    lastMessage: 'Thanks for your help!',
    lastMessageTime: 'Yesterday',
    unreadCount: 0,
  ),
  ChatUser(
    id: '8',
    name: 'Daniel Lee',
    avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800&q=80',
    isOnline: true,
    lastMessage: 'See you at the event',
    lastMessageTime: 'Yesterday',
    unreadCount: 0,
  ),
  ChatUser(
    id: '9',
    name: 'Ava Williams',
    avatarUrl: 'https://images.unsplash.com/photo-1517365830460-955ce3ccd263?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?w=800&q=80',
    isOnline: false,
    lastMessage: 'The presentation looks great',
    lastMessageTime: 'Tuesday',
    unreadCount: 0,
  ),
  ChatUser(
    id: '10',
    name: 'Ethan Davis',
    avatarUrl: 'https://images.unsplash.com/photo-1463453091185-61582044d556?w=200&q=80',
    coverUrl: 'https://images.unsplash.com/photo-1516541196182-6bdb0516ed27?w=800&q=80',
    isOnline: true,
    lastMessage: 'Let\'s collaborate',
    lastMessageTime: 'Monday',
    unreadCount: 0,
  ),
]; 