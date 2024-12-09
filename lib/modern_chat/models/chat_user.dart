/// Model class for chat users
class ChatUser {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool isPinned;

  ChatUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
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
    avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    isOnline: true,
    lastMessage: 'Hey! How are you doing?',
    lastMessageTime: '12:30',
    unreadCount: 2,
    isPinned: true,
  ),
  ChatUser(
    id: '2',
    name: 'James Rodriguez',
    avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
    isOnline: false,
    lastMessage: 'Let\'s meet tomorrow',
    lastMessageTime: '11:45',
    unreadCount: 0,
    isPinned: true,
  ),
  ChatUser(
    id: '3',
    name: 'Sophia Chen',
    avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
    isOnline: true,
    lastMessage: 'The project is done! 🎉',
    lastMessageTime: '10:18',
    unreadCount: 3,
    isPinned: true,
  ),
  ChatUser(
    id: '4',
    name: 'Marcus Johnson',
    avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e',
    isOnline: true,
    lastMessage: 'Can you check the docs?',
    lastMessageTime: '09:30',
    unreadCount: 0,
    isPinned: true,
  ),
  ChatUser(
    id: '5',
    name: 'Isabella Martinez',
    avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
    isOnline: false,
    lastMessage: 'Great idea! 👍',
    lastMessageTime: '09:15',
    unreadCount: 0,
    isPinned: true,
  ),
  ChatUser(
    id: '6',
    name: 'Alexander White',
    avatarUrl: 'https://images.unsplash.com/photo-1463453091185-61582044d556',
    isOnline: true,
    lastMessage: 'When is the meeting?',
    lastMessageTime: 'Yesterday',
    unreadCount: 1,
  ),
  ChatUser(
    id: '7',
    name: 'Olivia Brown',
    avatarUrl: 'https://images.unsplash.com/photo-1557555187-23d685287bc3',
    isOnline: false,
    lastMessage: 'Thanks for your help!',
    lastMessageTime: 'Yesterday',
    unreadCount: 0,
  ),
  ChatUser(
    id: '8',
    name: 'Daniel Lee',
    avatarUrl: 'https://images.unsplash.com/photo-1500048993953-d23a436266cf',
    isOnline: true,
    lastMessage: 'See you at the event',
    lastMessageTime: 'Yesterday',
    unreadCount: 0,
  ),
  ChatUser(
    id: '9',
    name: 'Ava Williams',
    avatarUrl: 'https://images.unsplash.com/photo-1524250502761-1ac6f2e30d43',
    isOnline: false,
    lastMessage: 'The presentation looks great',
    lastMessageTime: 'Tuesday',
    unreadCount: 0,
  ),
  ChatUser(
    id: '10',
    name: 'Ethan Davis',
    avatarUrl: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce',
    isOnline: true,
    lastMessage: 'Let\'s collaborate',
    lastMessageTime: 'Monday',
    unreadCount: 0,
  ),
]; 