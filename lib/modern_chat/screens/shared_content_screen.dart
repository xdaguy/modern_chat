import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/models/chat_user.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';

class SharedContentScreen extends StatefulWidget {
  final ChatUser user;

  const SharedContentScreen({super.key, required this.user});

  @override
  State<SharedContentScreen> createState() => _SharedContentScreenState();
}

class _SharedContentScreenState extends State<SharedContentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Shared Content',
          style: AppTextStyles.heading2.copyWith(
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          labelStyle: AppTextStyles.subtitle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          unselectedLabelStyle: AppTextStyles.subtitle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          tabs: const [
            Tab(text: 'Media'),
            Tab(text: 'Links'),
            Tab(text: 'Files'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMediaGrid(),
          _buildLinksList(),
          _buildFilesList(),
        ],
      ),
    );
  }

  Widget _buildMediaGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 20, // Sample count
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(
                'https://picsum.photos/200?random=$index',
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLinksList() {
    return ListView.builder(
      itemCount: 10, // Sample count
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.link,
              color: AppColors.primary,
            ),
          ),
          title: Text('Sample Link ${index + 1}'),
          subtitle: Text('https://example.com/link$index'),
          trailing: Text(
            '2h ago',
            style: AppTextStyles.subtitle,
          ),
        );
      },
    );
  }

  Widget _buildFilesList() {
    return ListView.builder(
      itemCount: 15, // Sample count
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.insert_drive_file,
              color: AppColors.primary,
            ),
          ),
          title: Text('Document_${index + 1}.pdf'),
          subtitle: Text('1.2 MB'),
          trailing: Text(
            '3d ago',
            style: AppTextStyles.subtitle,
          ),
        );
      },
    );
  }
} 