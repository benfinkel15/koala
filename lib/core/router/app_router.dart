import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:koala/features/auth/presentation/login_screen.dart';
import 'package:koala/features/auth/presentation/register_screen.dart';
import 'package:koala/features/home/presentation/home_screen.dart';
import 'package:koala/features/learn/presentation/learn_screen.dart';
import 'package:koala/features/learn/presentation/scenario_screen.dart';
import 'package:koala/features/lesson/presentation/lesson_screen.dart';
import 'package:koala/features/onboarding/presentation/onboarding_screen.dart';
import 'package:koala/features/profile/presentation/profile_screen.dart';
import 'package:koala/features/read/presentation/passage_screen.dart';
import 'package:koala/features/read/presentation/read_screen.dart';
import 'package:koala/features/review/presentation/review_screen.dart';
import 'package:koala/services/auth_service.dart';

final appRouter = GoRouter(
  initialLocation: '/learn',
  redirect: (context, state) async {
    final location = state.matchedLocation;

    if (AuthService.firebaseReady) {
      final isAuthenticated = AuthService.currentUser != null;
      if (!isAuthenticated) {
        if (location == '/login' || location == '/register') return null;
        return '/login';
      }
      if (location == '/login' || location == '/register') return '/learn';
    }

    if (location == '/onboarding') return null;
    final box = await Hive.openBox('settings');
    final done = box.get('onboardingComplete', defaultValue: false) as bool;
    if (!done) return '/onboarding';

    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child, location: state.matchedLocation),
      routes: [
        GoRoute(path: '/learn', builder: (_, __) => const LearnScreen()),
        GoRoute(path: '/read', builder: (_, __) => const ReadScreen()),
        GoRoute(path: '/review', builder: (_, __) => const ReviewScreen()),
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
      ],
    ),
    GoRoute(
      path: '/scenario/:id',
      builder: (_, state) => ScenarioScreen(scenarioId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/passage/:id',
      builder: (_, state) => PassageScreen(passageId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/lesson/:lessonId',
      builder: (_, state) => LessonScreen(lessonId: state.pathParameters['lessonId']!),
    ),
  ],
);

class MainScaffold extends StatelessWidget {
  final Widget child;
  final String location;
  const MainScaffold({super.key, required this.child, required this.location});

  int get _index {
    if (location.startsWith('/learn')) return 0;
    if (location.startsWith('/read')) return 1;
    if (location.startsWith('/review')) return 2;
    if (location.startsWith('/home')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) {
          switch (i) {
            case 0: context.go('/learn');
            case 1: context.go('/read');
            case 2: context.go('/review');
            case 3: context.go('/home');
            case 4: context.go('/profile');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bolt), label: 'Learn'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Read'),
          NavigationDestination(icon: Icon(Icons.replay_circle_filled), label: 'Review'),
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Classic'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
