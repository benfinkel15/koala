import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/services/auth_service.dart';
import 'package:koala/services/progress_service.dart';
import 'package:koala/services/streak_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _totalXp = 0;
  int _lessonsCompleted = 0;
  int _currentStreak = 0;
  int _longestStreak = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
    _loadStreak();
  }

  Future<void> _loadStats() async {
    final progress = await ProgressService.allProgress();
    int xp = 0;
    for (final v in progress.values) {
      xp += v['xp'] as int? ?? 0;
    }
    if (mounted) {
      setState(() {
        _totalXp = xp;
        _lessonsCompleted = progress.length;
      });
    }
  }

  Future<void> _loadStreak() async {
    final streak = await StreakService.getStreak();
    if (mounted) {
      setState(() {
        _currentStreak = streak['currentDays'] as int? ?? 0;
        _longestStreak = streak['longestDays'] as int? ?? 0;
      });
    }
  }

  Future<void> _signOut() async {
    await AuthService.signOut();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final level = _totalXp ~/ 100 + 1;
    final email = AuthService.currentUser?.email;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: _signOut,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.primaryDark,
            child: Icon(Icons.person, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              email ?? 'Learner',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          _StatRow(
              icon: Icons.local_fire_department,
              color: AppColors.streakOrange,
              label: 'Day Streak',
              value: '$_currentStreak'),
          _StatRow(
              icon: Icons.whatshot,
              color: AppColors.streakOrange,
              label: 'Longest Streak',
              value: '$_longestStreak'),
          _StatRow(
              icon: Icons.star,
              color: AppColors.xpGold,
              label: 'Total XP',
              value: '$_totalXp'),
          _StatRow(
              icon: Icons.emoji_events,
              color: AppColors.primary,
              label: 'Level',
              value: '$level'),
          _StatRow(
              icon: Icons.check_circle,
              color: AppColors.correct,
              label: 'Lessons Completed',
              value: '$_lessonsCompleted'),
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

  const _StatRow(
      {required this.icon,
      required this.color,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(value,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
