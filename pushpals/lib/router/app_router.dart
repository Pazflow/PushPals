import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/router/go_router_refresh_stream.dart';

// Importiere deine Screens
import '../screens/start_login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/after_registrierung_screen.dart';
import '../screens/eig_profile_screen.dart';
import '../screens/freund_einladen_screen.dart';
import '../screens/get_challenge_screen.dart';
import '../screens/add_challenge_screen.dart';
import '../screens/sended_challenge_screen.dart';
import '../screens/leaderboard_screen.dart';
import '../screens/passwort_vergessen_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(
    Supabase.instance.client.auth.onAuthStateChange,
  ),
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final loggedIn = session != null;
    final loggingIn = state.uri.toString() == '/';

    if (!loggedIn && !loggingIn) return '/';
    if (loggedIn && loggingIn) return '/home';

    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/after_registrierung',
      builder: (context, state) => const ProfileSetupWidget(),
    ),
    GoRoute(
      path: '/profil',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/freund_einladen',
      builder: (context, state) => const FriendSearchScreen(),
    ),
    GoRoute(
      path: '/challenge_uebersicht',
      builder: (context, state) => const GetChallengeScreen(),
    ),
    GoRoute(
      path: '/challenge_hinzufuegen',
      builder: (context, state) => const AddChallengeScreen(),
    ),
    GoRoute(
      path: '/gesendete_challenges',
      builder: (context, state) => const SendChallengeScreen(),
    ),
    GoRoute(
      path: '/leaderboard',
      builder: (context, state) => const LeaderboardScreen(),
    ),
    GoRoute(
      path: '/passwort-vergessen',
      builder: (context, state) => PasswortVergessenScreen(),
    ),
  ],
);
