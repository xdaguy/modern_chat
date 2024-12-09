import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildProfileCard(),
          const SizedBox(height: 16),
          _buildSettingsSection(
            title: 'General',
            items: [
              SettingsItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Message, group & call tones',
                onTap: () {
                  // Handle notifications
                },
              ),
              SettingsItem(
                icon: Icons.lock_outline,
                title: 'Privacy',
                subtitle: 'Block contacts, disappearing messages',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
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
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Privacy Settings',
                                  style: AppTextStyles.heading2.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 24),
                                _buildPrivacyOption(
                                  'Last Seen',
                                  'Everyone',
                                  Icons.visibility,
                                ),
                                _buildPrivacyOption(
                                  'Profile Photo',
                                  'My Contacts',
                                  Icons.photo,
                                ),
                                _buildPrivacyOption(
                                  'About',
                                  'Nobody',
                                  Icons.info,
                                ),
                                _buildPrivacySwitch(
                                  'Read Receipts',
                                  'Show when you read messages',
                                  true,
                                ),
                                _buildPrivacySwitch(
                                  'Disappearing Messages',
                                  'Messages disappear after 7 days',
                                  false,
                                ),
                                const SizedBox(height: 16),
                                ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.block,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                  title: const Text('Blocked Contacts'),
                                  subtitle: const Text('3 contacts'),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () {
                                    // Handle blocked contacts
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SettingsItem(
                icon: Icons.security_outlined,
                title: 'Security',
                subtitle: 'Password, 2-step verification',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
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
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Security Settings',
                                  style: AppTextStyles.heading2.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 24),
                                _buildSecurityOption(
                                  'Screen Lock',
                                  'Lock app with fingerprint or PIN',
                                  Icons.fingerprint,
                                  true,
                                ),
                                _buildSecurityOption(
                                  '2-Step Verification',
                                  'Add extra security to your account',
                                  Icons.security,
                                  false,
                                ),
                                _buildSecurityOption(
                                  'Active Sessions',
                                  'Manage devices where you\'re logged in',
                                  Icons.devices,
                                  false,
                                ),
                                const SizedBox(height: 16),
                                ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.history,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                  ),
                                  title: const Text('Login History'),
                                  subtitle: const Text('View recent account activities'),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () {
                                    // Handle login history
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            title: 'Appearance',
            items: [
              SettingsItem(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                subtitle: 'Dark, Light, System',
                trailing: _buildThemeSelector(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  'Choose Theme',
                                  style: AppTextStyles.heading2.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 24),
                                ListTile(
                                  leading: const Icon(Icons.light_mode, color: AppColors.primary),
                                  title: const Text('Light Theme'),
                                  trailing: const Icon(Icons.check_circle, color: AppColors.primary),
                                  onTap: () => Navigator.pop(context),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.dark_mode, color: AppColors.primary),
                                  title: const Text('Dark Theme'),
                                  onTap: () => Navigator.pop(context),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.settings_system_daydream, color: AppColors.primary),
                                  title: const Text('System Default'),
                                  onTap: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SettingsItem(
                icon: Icons.wallpaper_outlined,
                title: 'Chat Wallpaper',
                subtitle: 'Change chat background',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Handle wallpaper
                },
              ),
              SettingsItem(
                icon: Icons.text_fields_outlined,
                title: 'Font Size',
                subtitle: 'Small, Medium, Large',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.text_fields,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text('Font Size'),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildFontOption('Small', 0.9, context),
                          _buildFontOption('Medium', 1.0, context),
                          _buildFontOption('Large', 1.1, context),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            title: 'Data and Storage',
            items: [
              SettingsItem(
                icon: Icons.storage_outlined,
                title: 'Storage Usage',
                subtitle: 'Network usage and auto-download',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
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
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Storage Usage',
                                  style: AppTextStyles.heading2.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Total Space Used: 5.12 GB',
                                  style: AppTextStyles.subtitle.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _buildStorageItem('Photos', '1.2 GB', 0.4, Colors.blue),
                                _buildStorageItem('Videos', '3.5 GB', 0.7, Colors.green),
                                _buildStorageItem('Documents', '245 MB', 0.2, Colors.orange),
                                _buildStorageItem('Other', '180 MB', 0.1, Colors.purple),
                                const SizedBox(height: 24),
                                _buildStorageOption(
                                  'Auto-download media',
                                  'Download photos and videos automatically',
                                  true,
                                ),
                                _buildStorageOption(
                                  'Save to gallery',
                                  'Save received media to gallery',
                                  false,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SettingsItem(
                icon: Icons.data_usage_outlined,
                title: 'Network Usage',
                subtitle: 'Data saver and proxy settings',
                onTap: () {
                  // Handle network
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            title: 'About',
            items: [
              SettingsItem(
                icon: Icons.info_outline,
                title: 'App Info',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  // Handle app info
                },
              ),
              SettingsItem(
                icon: Icons.policy_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  // Handle privacy policy
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLogoutButton(context),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Version 1.0.0 (Build 100)',
          style: AppTextStyles.subtitle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Handle profile edit
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Image and Edit Button
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.7),
                          AppColors.primary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: UserAvatar(
                      imageUrl: 'https://picsum.photos/200',
                      size: 100,
                      isOnline: true,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // User Info
              Text(
                'John Doe',
                style: AppTextStyles.heading2.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
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
                          Icons.mail_outline,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'john.doe@gmail.com',
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Stats with Dividers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileStat('Photos', '128'),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  _buildProfileStat('Videos', '53'),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  _buildProfileStat('Files', '241'),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(height: 1),
              ),
              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickAction(Icons.qr_code_scanner_rounded, 'QR Code'),
                  _buildQuickAction(Icons.share_rounded, 'Share'),
                  _buildQuickAction(Icons.cloud_upload_rounded, 'Backup'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: double.parse(value)),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Column(
        children: [
          Text(
            value.toInt().toString(),
            style: AppTextStyles.heading2.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.subtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<SettingsItem> items,
    String? description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
              if (description != null) ...[
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  _buildSettingsItemTile(item),
                  if (index < items.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(height: 1),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItemTile(SettingsItem item) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          title: Text(
            item.title,
            style: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          subtitle: item.subtitle != null
              ? Text(
                  item.subtitle!,
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                )
              : null,
          trailing: item.trailing ?? 
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.textSecondary,
              ),
            ),
        ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Light',
        style: AppTextStyles.subtitle.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.logout_outlined,
                      color: Colors.red[600],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              content: const Text(
                'Are you sure you want to logout from Modern Chat?',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle logout
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red[600],
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        },
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.logout_outlined,
            color: Colors.red,
          ),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildFontOption(String label, double scale, BuildContext dialogContext) {
    return ListTile(
      title: Text(
        'Preview Text',
        style: TextStyle(fontSize: 16 * scale),
      ),
      subtitle: Text(label),
      trailing: Radio(
        value: scale,
        groupValue: 1.0, // Current scale
        activeColor: AppColors.primary,
        onChanged: (value) {
          // Handle font size change
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  Widget _buildStorageItem(String label, String size, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.subtitle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              size,
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStorageOption(String title, String subtitle, bool value) {
    return StatefulBuilder(
      builder: (context, setState) => SwitchListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.subtitle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        value: value,
        activeColor: AppColors.primary,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    );
  }

  Widget _buildPrivacyOption(String title, String value, IconData icon) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
      ),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary,
          ),
        ],
      ),
      onTap: () {
        // Handle option change
      },
    );
  }

  Widget _buildPrivacySwitch(String title, String subtitle, bool value) {
    return StatefulBuilder(
      builder: (context, setState) => SwitchListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.subtitle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        value: value,
        activeColor: AppColors.primary,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    );
  }

  Widget _buildSecurityOption(String title, String subtitle, IconData icon, bool value) {
    return StatefulBuilder(
      builder: (context, setState) => ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.subtitle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        trailing: Switch(
          value: value,
          activeColor: AppColors.primary,
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}

class SettingsItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });
}