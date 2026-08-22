import 'package:flutter/material.dart';
import '../widgets/CustomButton.dart';
import '../theme/app_colors.dart';

/// Profile tab — simple static UI, third tab of the bottom navigation.
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 44,
            backgroundColor: AppColors.tint,
            child: Icon(Icons.person, size: 46, color: AppColors.primary),
          ),
          const SizedBox(height: 14),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const Text(
            'john.doe@example.com',
            style: TextStyle(color: AppColors.textGrey),
          ),
          const SizedBox(height: 24),
          _ProfileTile(icon: Icons.person_outline, label: 'Edit Profile'),
          _ProfileTile(icon: Icons.lock_outline, label: 'Change Password'),
          _ProfileTile(icon: Icons.notifications_none, label: 'Notifications'),
          _ProfileTile(icon: Icons.help_outline, label: 'Help & Support'),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Log Out',
            color: AppColors.danger,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.tintBorder),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(label, style: const TextStyle(color: AppColors.textDark)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textGrey),
        onTap: () {},
      ),
    );
  }
}