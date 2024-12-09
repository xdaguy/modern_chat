import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';
import 'package:modern_chat/modern_chat/widgets/story_ring.dart';
import 'package:modern_chat/modern_chat/screens/chat_detail_screen.dart';
import 'package:modern_chat/modern_chat/models/chat_user.dart';
import 'package:modern_chat/modern_chat/screens/profile_screen.dart';
import 'package:modern_chat/modern_chat/widgets/animated_list_item.dart';
import 'package:modern_chat/modern_chat/widgets/shimmer_loading.dart';
import 'package:modern_chat/modern_chat/models/story.dart';
import 'package:modern_chat/modern_chat/screens/status_view_screen.dart';
import 'package:modern_chat/modern_chat/models/call.dart';
import 'package:modern_chat/modern_chat/screens/new_chat_screen.dart';
import 'package:modern_chat/modern_chat/utils/page_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<ChatUser> filteredUsers = [];
  String searchQuery = '';
  bool _isLoading = true;
  bool _isRefreshing = false;
  List<Story> _stories = [];
  List<Call> _calls = [];
  late TabController _tabController;
  int _currentTabIndex = 0;
  late AnimationController _bottomSheetController;

  @override
  void initState() {
    super.initState();
    _loadData();
    _stories = List.from(sampleStories);
    _calls = List.from(sampleCalls);
    
    // Initialize controllers
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });

    _bottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bottomSheetController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        filteredUsers = List.from(sampleUsers);
        _isLoading = false;
      });
    }
  }

  void _handleSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      if (query.isEmpty) {
        filteredUsers = List.from(sampleUsers);
      } else {
        filteredUsers = sampleUsers.where((user) {
          return user.name.toLowerCase().contains(searchQuery) ||
              user.lastMessage.toLowerCase().contains(searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildChatList(),
          _buildStatusList(),
          _buildCallsList(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
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
              AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: Offset(_currentTabIndex == 0 ? 0 : 0.2, 0),
                curve: Curves.easeInOutCubic,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _currentTabIndex == 0 ? 1.0 : 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 24,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: ChatSearchDelegate(users: sampleUsers),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: Offset(_currentTabIndex == 0 ? 0 : -0.5, 0),
                curve: Curves.easeInOutCubic,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _currentTabIndex == 0 ? 1.0 : 0.0,
                  child: _currentTabIndex == 0
                      ? Container(
                          key: const ValueKey('filter'),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                              size: 24,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            offset: const Offset(0, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onSelected: (value) {
                              setState(() {
                                switch (value) {
                                  case 'all_chats':
                                    filteredUsers = List.from(sampleUsers);
                                    break;
                                  case 'unread':
                                    filteredUsers = sampleUsers.where((user) => user.unreadCount > 0).toList();
                                    break;
                                  case 'groups':
                                    // Add group filtering logic
                                    break;
                                  case 'archived':
                                    // Add archived filtering logic
                                    break;
                                }
                              });
                            },
                            itemBuilder: (context) => [
                              _buildFilterItem('All Chats', Icons.chat),
                              _buildFilterItem('Unread', Icons.mark_chat_unread),
                              _buildFilterItem('Groups', Icons.group),
                              _buildFilterItem('Archived', Icons.archive),
                            ],
                          ),
                        )
                      : const SizedBox(key: ValueKey('no-filter'), width: 0),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
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
            controller: _tabController,
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
    if (_isLoading) {
      return _buildLoadingState();
    }

    final pinnedUsers = filteredUsers.where((user) => user.isPinned).toList();
    final regularUsers = filteredUsers.where((user) => !user.isPinned).toList();
    
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        setState(() => _isRefreshing = true);
        await _loadData();
        setState(() => _isRefreshing = false);
      },
      child: CustomScrollView(
        slivers: [
          if (pinnedUsers.isNotEmpty)
            SliverToBoxAdapter(
              child: _PinnedChatsSection(users: pinnedUsers),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    searchQuery.isEmpty ? 'Recent Chats' : 'Search Results',
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (searchQuery.isEmpty)
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.sort, size: 18),
                      label: const Text(
                        'Sort',
                        style: TextStyle(fontSize: 13),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => AnimatedListItem(
                index: index,
                child: _buildChatTile(context, regularUsers[index]),
              ),
              childCount: regularUsers.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, ChatUser user) {
    return Hero(
      tag: 'chat_${user.id}',
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  SlidePageRoute(
                    child: ChatDetailScreen(user: user),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.1),
                          width: 1.5,
                        ),
                      ),
                      child: UserAvatar(
                        imageUrl: user.avatarUrl,
                        isOnline: user.isOnline,
                        size: 50,
                      ),
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
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.name,
                            style: AppTextStyles.heading2.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          user.lastMessageTime,
                          style: AppTextStyles.subtitle.copyWith(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.done_all,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            user.lastMessage,
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (user.unreadCount > 0) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              user.unreadCount.toString(),
                              style: AppTextStyles.subtitle.copyWith(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.5,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              )),
              child: child,
            ),
          ),
        );
      },
      child: _buildFABForCurrentTab(context),
    );
  }

  Widget _buildFABForCurrentTab(BuildContext context) {
    switch (_currentTabIndex) {
      case 0: // Chats tab
        return Container(
          key: const ValueKey('chat_fab'),
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
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                transitionAnimationController: _bottomSheetController,
                builder: (context) => _buildQuickActionsSheet(),
              );
            },
            child: Icon(
              Icons.chat_bubble_outline,
              color: AppColors.primary,
            ),
          ),
        );

      case 1: // Status tab
        return FloatingActionButton(
          key: const ValueKey('status_fab'),
          backgroundColor: Colors.white,
          child: Icon(
            Icons.camera_alt,
            color: AppColors.primary,
          ),
          onPressed: () {
            // Handle add status
          },
        );

      case 2: // Calls tab
        return FloatingActionButton(
          key: const ValueKey('calls_fab'),
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_call,
            color: AppColors.primary,
          ),
          onPressed: () {
            // Handle new call
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildQuickActionsSheet() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * value),
          child: Opacity(
            opacity: 1 - value,
            child: child,
          ),
        );
      },
      child: Container(
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
          onTap: () {
            Navigator.pop(context); // Close bottom sheet
            Navigator.push(
              context,
              SlidePageRoute(
                child: const NewChatScreen(),
                direction: SlideDirection.up,
              ),
            );
          },
        ),
        _buildQuickActionItem(
          Icons.group_add,
          'New Group',
          Colors.green,
          onTap: () {
            // Handle new group
          },
        ),
        _buildQuickActionItem(
          Icons.broadcast_on_personal,
          'Broadcast',
          Colors.orange,
          onTap: () {
            // Handle broadcast
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, Color color, {VoidCallback? onTap}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.5 + (value * 0.5),
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Column(
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
        ),
      ),
    );
  }

  Widget _buildStatusList() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    final recentStories = _stories
        .where((story) =>
            story.timestamp.isAfter(DateTime.now().subtract(const Duration(hours: 24))))
        .toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
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
                        Icons.update,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Recent Updates',
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
                  '${recentStories.length} new',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final story = recentStories[index];
              final user = sampleUsers.firstWhere((u) => u.id == story.userId);
              return _buildStoryTile(user, story);
            },
            childCount: recentStories.length,
          ),
        ),
      ],
    );
  }

  Widget _buildStoryTile(ChatUser user, Story story) {
    final timeAgo = _getTimeAgo(story.timestamp);
    
    return Hero(
      tag: 'story_${story.id}',
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                FadePageRoute(
                  child: StatusViewScreen(user: user, story: story),
                ),
              );
            },
            child: Row(
              children: [
                StoryRing(
                  size: 52,
                  imageUrl: user.avatarUrl,
                  isViewed: story.isViewed,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user.name,
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (!story.isViewed)
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Text(
                            timeAgo,
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            ' • ${story.items.length} items',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 13,
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
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return 'Yesterday';
    }
  }

  Widget _buildCallsList() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    final recentCalls = _calls.where((call) => 
      call.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).toList();

    final olderCalls = _calls.where((call) => 
      !call.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
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
                    Icons.access_time,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Recent',
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (recentCalls.isNotEmpty) ...[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final call = recentCalls[index];
                final user = sampleUsers.firstWhere((u) => u.id == call.userId);
                return _buildCallTile(user, call);
              },
              childCount: recentCalls.length,
            ),
          ),
        ],
        if (olderCalls.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Older',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final call = olderCalls[index];
                final user = sampleUsers.firstWhere((u) => u.id == call.userId);
                return _buildCallTile(user, call);
              },
              childCount: olderCalls.length,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCallTile(ChatUser user, Call call) {
    final timeAgo = _getTimeAgo(call.timestamp);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(8),
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
      child: Row(
        children: [
          Stack(
            children: [
              UserAvatar(
                imageUrl: user.avatarUrl,
                size: 50,
                isOnline: user.isOnline,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: call.type == CallType.video ? Colors.blue : Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    call.type == CallType.video ? Icons.videocam : Icons.call,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user.name,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      call.status == CallStatus.incoming
                          ? Icons.call_received
                          : call.status == CallStatus.outgoing
                              ? Icons.call_made
                              : Icons.call_missed,
                      size: 14,
                      color: call.status == CallStatus.missed
                          ? Colors.red
                          : Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo,
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    if (call.duration > 0) ...[
                      Text(
                        ' • ',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        _formatDuration(call.duration),
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                call.type == CallType.video ? Icons.videocam : Icons.call,
                color: AppColors.primary,
                size: 20,
              ),
              onPressed: () {
                // Handle call
              },
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds - minutes * 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildSwipeableChat(BuildContext context, ChatUser user) {
    return Dismissible(
      key: Key(user.id),
      background: _buildSwipeBackground(
        alignment: Alignment.centerLeft,
        color: Colors.blue,
        icon: Icons.archive,
        label: 'Archive',
      ),
      secondaryBackground: _buildSwipeBackground(
        alignment: Alignment.centerRight,
        color: Colors.red,
        icon: Icons.delete,
        label: 'Delete',
      ),
      onDismissed: (direction) {
        // Handle swipe actions
      },
      child: _buildChatTile(context, user),
    );
  }

  Widget _buildSwipeBackground({
    required Alignment alignment,
    required Color color,
    required IconData icon,
    required String label,
  }) {
    return Container(
      color: color,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildFilterItem(String title, IconData icon) {
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

  Widget _buildLoadingState() {
    return ListView.builder(
      itemCount: 8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) => _buildLoadingTile(),
    );
  }

  Widget _buildLoadingTile() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
          ShimmerLoading(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShimmerLoading(
                      baseColor: Colors.grey[200],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: 120,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ShimmerLoading(
                      baseColor: Colors.grey[200],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: 40,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ShimmerLoading(
                      baseColor: Colors.grey[200],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ShimmerLoading(
                      baseColor: Colors.grey[200],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: 180,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
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
    );
  }
}

class _PinnedChatsSection extends StatelessWidget {
  final List<ChatUser> users;

  const _PinnedChatsSection({required this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
                      Icons.push_pin,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Pinned',
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
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                child: Text(
                  'See all',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 84,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return _PinnedChatItem(user: users[index]);
            },
          ),
        ),
        const SizedBox(height: 4),
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
        SlidePageRoute(
          child: ChatDetailScreen(user: user),
        ),
      ),
      child: Container(
        width: 72,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                ScalePageRoute(
                  child: ProfileScreen(user: user),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.1),
                    width: 1.5,
                  ),
                ),
                child: UserAvatar(
                  imageUrl: user.avatarUrl,
                  isOnline: user.isOnline,
                  size: 52,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  user.name,
                  style: AppTextStyles.subtitle.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatSearchDelegate extends SearchDelegate<String> {
  final List<ChatUser> users;

  ChatSearchDelegate({required this.users});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filteredUsers = users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.lastMessage.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return ListTile(
          leading: UserAvatar(
            imageUrl: user.avatarUrl,
            isOnline: user.isOnline,
          ),
          title: Text(user.name),
          subtitle: Text(
            user.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            close(context, user.id);
            Navigator.push(
              context,
              SlidePageRoute(
                child: ChatDetailScreen(user: user),
                direction: SlideDirection.up,
              ),
            );
          },
        );
      },
    );
  }
} 