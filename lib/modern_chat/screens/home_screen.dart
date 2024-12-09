import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';
import 'package:modern_chat/modern_chat/widgets/story_ring.dart';
import 'package:modern_chat/modern_chat/screens/chat_detail_screen.dart';
import 'package:modern_chat/modern_chat/models/chat_user.dart';
import 'package:modern_chat/modern_chat/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: TabBarView(
          children: [
            _buildChatList(),
            _buildStatusList(),
            _buildCallsList(),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      toolbarHeight: 100,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Modern Chat',
                    style: AppTextStyles.heading1.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Connect with friends',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  offset: const Offset(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  itemBuilder: (context) => [
                    _buildMenuItem(Icons.group_add, 'New Group'),
                    _buildMenuItem(Icons.settings, 'Settings'),
                    _buildMenuItem(Icons.dark_mode, 'Theme'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            unselectedLabelStyle: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
            tabs: [
              _buildTab('Chats', '5'),
              _buildTab('Stories', '12'),
              _buildTab('Calls', '3'),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(IconData icon, String title) {
    return PopupMenuItem(
      value: title.toLowerCase(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, String count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          if (count.isNotEmpty) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChatList() {
    final pinnedUsers = sampleUsers.where((user) => user.isPinned).toList();
    final regularUsers = sampleUsers.where((user) => !user.isPinned).toList();

    return CustomScrollView(
      slivers: [
        if (pinnedUsers.isNotEmpty)
          SliverToBoxAdapter(
            child: _PinnedChatsSection(users: pinnedUsers),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildChatTile(context, regularUsers[index]),
            childCount: regularUsers.length,
          ),
        ),
      ],
    );
  }

  Widget _buildChatTile(BuildContext context, ChatUser user) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailScreen(user: user),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: user),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.1),
                        width: 2,
                      ),
                    ),
                    child: UserAvatar(
                      imageUrl: user.avatarUrl,
                      isOnline: user.isOnline,
                      size: 60,
                    ),
                  ),
                  if (user.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 18,
                        height: 18,
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
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        user.lastMessageTime,
                        style: AppTextStyles.subtitle.copyWith(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.done_all,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          user.lastMessage,
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (user.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            user.unreadCount.toString(),
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => _buildQuickActionsSheet(),
          );
        },
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          'New Chat',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionsSheet() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start a conversation',
                  style: AppTextStyles.heading2.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  'Choose how you want to start',
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 24),
                _buildQuickActionGrid(),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildQuickActionGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildQuickActionItem(
          Icons.message,
          'New Chat',
          Colors.blue,
        ),
        _buildQuickActionItem(
          Icons.group_add,
          'New Group',
          Colors.green,
        ),
        _buildQuickActionItem(
          Icons.broadcast_on_personal,
          'Broadcast',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.subtitle.copyWith(
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatusList() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMyStatus(),
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                child: Text(
                  'Recent Updates',
                  style: AppTextStyles.subtitle,
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildStatusTile(),
            childCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildMyStatus() {
    return ListTile(
      leading: StoryRing(
        size: 56,
        isOwn: true,
        onTap: () {
          // Handle my status tap
        },
      ),
      title: Text(
        'My Status',
        style: AppTextStyles.heading2.copyWith(fontSize: 16),
      ),
      subtitle: const Text(
        'Tap to add status update',
        style: AppTextStyles.subtitle,
      ),
    );
  }

  Widget _buildStatusTile() {
    return ListTile(
      onTap: () {
        // Navigate to status view screen
      },
      leading: const StoryRing(
        size: 56,
        isViewed: false,
      ),
      title: Text(
        'Jane Smith',
        style: AppTextStyles.heading2.copyWith(fontSize: 16),
      ),
      subtitle: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const Text(
            '2 minutes ago',
            style: AppTextStyles.subtitle,
          ),
        ],
      ),
    );
  }

  Widget _buildCallsList() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.link,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                title: Text(
                  'Create call link',
                  style: AppTextStyles.heading2.copyWith(fontSize: 16),
                ),
                subtitle: const Text(
                  'Share a link for your WhatsApp call',
                  style: AppTextStyles.subtitle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                child: Text(
                  'Recent',
                  style: AppTextStyles.subtitle,
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildCallTile(),
            childCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildCallTile() {
    return ListTile(
      leading: const UserAvatar(size: 56),
      title: Text(
        'Alice Johnson',
        style: AppTextStyles.heading2.copyWith(fontSize: 16),
      ),
      subtitle: Row(
        children: [
          const Icon(
            Icons.call_made,
            size: 16,
            color: Colors.green,
          ),
          const SizedBox(width: 4),
          Text(
            'Today, 14:26',
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.videocam,
          color: AppColors.primary,
        ),
        onPressed: () {
          // Handle video call
        },
      ),
    );
  }
}

class _PinnedChatsSection extends StatelessWidget {
  final List<ChatUser> users;

  const _PinnedChatsSection({required this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.push_pin,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Pinned',
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return _PinnedChatItem(user: users[index]);
            },
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.filter_list,
                color: AppColors.primary,
              ),
              const SizedBox(width: 12),
              Text(
                'Filter conversations',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '3',
                  style: AppTextStyles.subtitle.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _PinnedChatItem extends StatelessWidget {
  final ChatUser user;

  const _PinnedChatItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailScreen(user: user),
        ),
      ),
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: user),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.1),
                    width: 2,
                  ),
                ),
                child: UserAvatar(
                  imageUrl: user.avatarUrl,
                  isOnline: user.isOnline,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                user.name,
                style: AppTextStyles.subtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 