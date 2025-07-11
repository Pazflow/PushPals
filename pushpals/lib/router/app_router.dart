import 'package:go_router/go_router.dart';
import 'package:pushpals/router/go_router_refresh_stream.dart';
import 'package:pushpals/screens/my_friends_screen.dart';

// Importiere deine Screens
import '../screens/start_login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/after_registrierung_screen.dart';
import '../screens/eig_profile_screen.dart';
import '../screens/freund_einladen_screen.dart';
import '../screens/get_challenge_screen.dart';
import '../screens/add_challenge_screen.dart';
import '../screens/send_challenge_screen.dart';
import '../screens/leaderboard_screen.dart';
import '../screens/passwort_vergessen_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(
    Supabase.instance.client.auth.onAuthStateChange,
  ),
  redirect: (context, state) async {
    final session = Supabase.instance.client.auth.currentSession;
    final loggedIn = session != null;
    final loggingIn = state.uri.toString() == '/';

    final publicRoutes = ['/', '/passwort-vergessen', '/after_registrierung'];

    if (!loggedIn && !publicRoutes.contains(state.uri.toString())) {
      return '/';
    }

    if (loggedIn) {
      final userId = session.user.id;
      final response =
          await Supabase.instance.client
              .from('users')
              .select()
              .eq('id', userId)
              .single();
      final username = response['username'];
      final birthday = response['birthday'];
      if ((username == null || username.isEmpty) ||
          (birthday == null || birthday.isEmpty)) {
        if (state.uri.toString() != '/after_registrierung') {
          return '/after_registrierung';
        }
      } else if (loggingIn) {
        return '/home';
      }
    }
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
      path: '/meine_freunde',
      builder: (context, state) => const MyFriendsScreen(),
    ),
    GoRoute(
      path: '/freund_einladen',
      builder: (context, state) => const FriendSearchScreen(),
    ),
    GoRoute(
      path: '/challenge_details',
      builder: (context, state) => const GetChallengeScreen(),
    ),
    GoRoute(
      path: '/challenge_hinzufuegen',
      builder: (context, state) => const AddChallengeScreen(),
    ),
    GoRoute(
      path: '/send_challenges',
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
