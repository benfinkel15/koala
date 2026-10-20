import 'package:flutter/material.dart';
import 'package:koala/core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(radius: 48, backgroundColor: AppColors.primaryDark,
              child: Icon(Icons.person, size: 48, color: Colors.white)),
          const SizedBox(height: 16),
          const Center(child: Text('Ben', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 32),
          _StatRow(icon: Icons.local_fire_department, color: AppColors.streakOrange, label: 'Day Streak', value: '3'),
          _StatRow(icon: Icons.star, color: AppColors.xpGold, label: 'Total XP', value: '340'),
          _StatRow(icon: Icons.emoji_events, color: AppColors.primary, label: 'Level', value: '4'),
          _StatRow(icon: Icons.check_circle, color: AppColors.correct, label: 'Lessons Completed', value: '2'),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatRow({required this.icon, required this.color, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
