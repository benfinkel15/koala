import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/core/router/app_router.dart';
import 'package:koala/firebase_options.dart';
import 'package:koala/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  try {
    final opts = DefaultFirebaseOptions.currentPlatform;
    if (opts.apiKey != 'REPLACE_WITH_API_KEY') {
      await Firebase.initializeApp(options: opts);
      AuthService.firebaseReady = true;
    }
  } catch (_) {
    // Firebase not configured yet — run `flutterfire configure` to set up
  }
  runApp(const ProviderScope(child: KoalaApp()));
}

class KoalaApp extends StatelessWidget {
  const KoalaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Koala',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
    );
  }
}
