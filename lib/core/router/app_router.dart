import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:koala/features/conversation/presentation/conversation_screen.dart';
import 'package:koala/features/home/presentation/home_screen.dart';
import 'package:koala/features/lesson/presentation/lesson_screen.dart';
import 'package:koala/features/onboarding/presentation/onboarding_screen.dart';
import 'package:koala/features/profile/presentation/profile_screen.dart';
import 'package:koala/features/review/presentation/review_screen.dart';
import 'package:koala/features/vocab/presentation/vocab_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) async {
    if (state.matchedLocation == '/onboarding') return null;
    final box = await Hive.openBox('settings');
    final done = box.get('onboardingComplete', defaultValue: false) as bool;
    if (!done) return '/onboarding';
    return null;
  },
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/review',
          builder: (context, state) => const ReviewScreen(),
        ),
        GoRoute(
          path: '/vocab',
          builder: (context, state) => const VocabScreen(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ConversationScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/lesson/:lessonId',
      builder: (context, state) => LessonScreen(
        lessonId: state.pathParameters['lessonId']!,
      ),
    ),
  ],
);

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              context.go('/home');
            case 1:
              context.go('/review');
            case 2:
              context.go('/vocab');
            case 3:
              context.go('/chat');
            case 4:
              context.go('/profile');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Learn'),
          NavigationDestination(icon: Icon(Icons.replay_circle_filled), label: 'Review'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Vocab'),
          NavigationDestination(icon: Icon(Icons.chat_bubble), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
