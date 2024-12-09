import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/models/chat_user.dart';
import 'package:modern_chat/modern_chat/screens/chat_detail_screen.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  String searchQuery = '';
  List<ChatUser> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(sampleUsers);
  }

  void _handleSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      if (query.isEmpty) {
        filteredUsers = List.from(sampleUsers);
      } else {
        filteredUsers = sampleUsers.where((user) {
          return user.name.toLowerCase().contains(searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: TextField(
          onChanged: _handleSearch,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search users...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Available Users',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${filteredUsers.length} users',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return _buildUserTile(user);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(ChatUser user) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(user: user),
            ),
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Stack(
          children: [
            UserAvatar(
              imageUrl: user.avatarUrl,
              size: 50,
              isOnline: user.isOnline,
            ),
            if (user.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.online,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          user.name,
          style: AppTextStyles.heading2.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          user.isOnline ? 'Online' : 'Offline',
          style: AppTextStyles.subtitle.copyWith(
            color: user.isOnline ? AppColors.online : AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        trailing: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.chat_bubble_outline,
              size: 20,
            ),
            color: AppColors.primary,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(user: user),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
} 