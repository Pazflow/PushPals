import 'package:flutter/material.dart';
import 'router/app_router.dart'; // unsere Router-Datei

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'PushPals',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
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

