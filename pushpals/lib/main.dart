import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'router/app_router.dart'; // unsere Router-Datei
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xmmidvlfmcfjlvcstswm.supabase.co', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhtbWlkdmxmbWNmamx2Y3N0c3dtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkyMDY2MTQsImV4cCI6MjA2NDc4MjYxNH0.FGMwi7MKyzDUhECmUxSRdIPKDI1TLh6vXViGMRaJI28',                     // <- ERSETZEN
  );

  final supabase = Supabase.instance.client;
  final session = supabase.auth.currentSession;

  if (session != null) {
    print("✅ User eingeloggt: ${session.user?.email}");
  } else {
    print("🚫 Kein User eingeloggt.");
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'PushPals',
      theme: ThemeData( textTheme: GoogleFonts.michromaTextTheme()
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

