import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_chat/modern_chat/models/chat_user.dart';
import 'package:modern_chat/modern_chat/models/story.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';
import 'package:modern_chat/modern_chat/screens/profile_screen.dart';

class StatusViewScreen extends StatefulWidget {
  final ChatUser user;
  final Story story;

  const StatusViewScreen({
    super.key,
    required this.user,
    required this.story,
  });

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  int _currentItemIndex = 0;
  bool _isLoading = true;
  bool _isPaused = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _nextStory();
        }
      });

    // Load first image after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentImage();
    });
  }

  Future<void> _loadCurrentImage() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _isInitialized = false;
    });

    try {
      final image = NetworkImage(widget.story.items[_currentItemIndex].imageUrl);
      await precacheImage(image, context);
      
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
        _isInitialized = true;
        if (!_isPaused) _progressController.forward(from: 0.0);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isInitialized = true;
      });
    }
  }

  void _nextStory() {
    if (_currentItemIndex < widget.story.items.length - 1) {
      setState(() {
        _currentItemIndex++;
        _progressController.stop();
        _loadCurrentImage();
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (_currentItemIndex > 0) {
      setState(() {
        _currentItemIndex--;
        _progressController.stop();
        _loadCurrentImage();
      });
    }
  }

  void _handleTapDown(TapDownDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tapPosition = details.globalPosition.dx;
    
    // Left third of screen - previous story
    if (tapPosition < screenWidth / 3) {
      _previousStory();
    }
    // Right third of screen - next story
    else if (tapPosition > (screenWidth * 2 / 3)) {
      _nextStory();
    }
    // Middle third - pause/play
    else {
      setState(() {
        _isPaused = !_isPaused;
        if (_isPaused) {
          _progressController.stop();
        } else {
          _progressController.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.story.items[_currentItemIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: _handleTapDown,
        child: Stack(
          children: [
            // Story Image
            if (!_isInitialized || _isLoading)
              _buildLoadingState()
            else
              Image.network(
                currentItem.imageUrl,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => _buildErrorState(),
              ),

            // Progress Indicators
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 8,
              right: 8,
              child: Row(
                children: List.generate(
                  widget.story.items.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1),
                        child: SizedBox(
                          height: 2,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.white.withOpacity(0.3),
                              ),
                              AnimatedBuilder(
                                animation: _progressController,
                                builder: (context, child) {
                                  return FractionallySizedBox(
                                    widthFactor: index == _currentItemIndex
                                        ? _progressController.value
                                        : index < _currentItemIndex
                                            ? 1.0
                                            : 0.0,
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Pause indicator
            if (_isPaused)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.pause,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),

            // User Info
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _navigateToProfile,
                    child: UserAvatar(
                      imageUrl: widget.user.avatarUrl,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: _navigateToProfile,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.user.name,
                            style: AppTextStyles.heading2.copyWith(color: Colors.white),
                          ),
                          Text(
                            _getTimeAgo(widget.story.timestamp),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
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

  Widget _buildLoadingState({double? progress}) {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildUserInfo(
              onTap: () => _navigateToProfile(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 64,
              height: 64,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 3,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              progress != null 
                  ? '${(progress * 100).toInt()}%'
                  : 'Loading story...',
              style: AppTextStyles.subtitle.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildUserInfo(
              onTap: () => _navigateToProfile(),
            ),
            const SizedBox(height: 40),
            Icon(
              Icons.wifi_off_rounded,
              color: Colors.red[300],
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'No internet connection',
              style: TextStyle(
                color: Colors.red[300],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your connection\nand try again',
              textAlign: TextAlign.center,
              style: AppTextStyles.subtitle.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAvatar(
            imageUrl: widget.user.avatarUrl,
            size: 80,
            isOnline: widget.user.isOnline,
          ),
          const SizedBox(height: 16),
          Text(
            widget.user.name,
            style: AppTextStyles.heading2.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(user: widget.user),
      ),
    );
  }
} 