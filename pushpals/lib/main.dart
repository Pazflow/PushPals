import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'router/app_router.dart'; // unsere Router-Datei
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/profile_setup_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  final supabase = Supabase.instance.client;
  final session = supabase.auth.currentSession;

  if (session != null) {
    print("✅ User eingeloggt: ${session.user.email}");
  } else {
    print("🚫 Kein User eingeloggt.");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChallengeModel()),
        ChangeNotifierProvider(
          create: (_) => ProfileSetupModel(),
        ), // ➕ HINZUGEFÜGT
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'PushPals',
      theme: ThemeData(
        textTheme: GoogleFonts.michromaTextTheme(),
        //theme: ThemeData(
        //  useMaterial3: true,
        //  colorSchemeSeed: Colors.deepPurple,
      ),
    );
  }
}



///Dieser Kontext ist für das einzelne Ansehen der Widgets oder Screens
/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Preview',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WidgetPreview(),
    );
  }
}

class WidgetPreview extends StatelessWidget {
   const WidgetPreview({super.key});

  

  @override
  Widget build(BuildContext context) {
    // Hier wird das Widget ausgewählt
  final Widget widgetToShow = LoginScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Preview'),
      ),
      body: Center(
        child: widgetToShow,// SaveButton(onPressed: (){}), wenn man nur den button sehen möchte, dann hier widgetToShow raus, button rein, und oben final Widget auskommentieren
      ),
    );
  }
}
*/

