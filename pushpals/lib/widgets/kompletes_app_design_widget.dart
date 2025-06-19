import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushpals/widgets/floatingbutton_widget.dart';

class AppDesign extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool showBack;
  final bool showProfile;
  final Widget? floatingActionButton;
  final int selectedIndex;
  final bool showBottomNav;
  final bool showFloatingButton;
  final bool showAppBar;

  const AppDesign({
    super.key,
    this.title,
    required this.child,
    this.showBack = true,
    this.showProfile = true,
    this.floatingActionButton,
    this.selectedIndex = 0,
    this.showBottomNav = true,
    this.showFloatingButton = true,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06101F),
      appBar:
          showAppBar
              ? AppBar(
                backgroundColor: const Color(0xFF0084FF),
                elevation: 0,
                leading:
                    showBack
                        ? BackButton(
                          color: const Color(0xFF06101F),
                          onPressed: () => context.go('/home'),
                        )
                        : null,
                title:
                    title != null
                        ? Text(
                          title!,

                          style: GoogleFonts.michroma(
                            color: const Color(0xFF06101F),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : null,
                centerTitle: false,
                actions:
                    showProfile
                        ? [
                          IconButton(
                            icon: const Icon(
                              Icons.account_circle,
                              color: Color(0xFF06101F),
                            ),
                            onPressed: () {
                              context.go('/profil');
                            },
                          ),
                        ]
                        : null,
              )
              : null,

      body: Padding(padding: const EdgeInsets.all(24), child: child),

      floatingActionButton:
          showFloatingButton
              ? (floatingActionButton ??
                  FloatingButtonWidget(
                    onPressed:
                        () => GoRouter.of(context).go('/challenge_hinzufuegen'),
                    icon: Icons.add,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ))
              : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar:
          showBottomNav
              ? BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/home');
                      break;
                    case 1:
                      context.go('/leaderboard');
                      break;
                  }
                },
                backgroundColor: const Color(0xFF0084FF),
                selectedItemColor: const Color(0xFFFFA632),
                unselectedItemColor: const Color(0xFF06101F),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.leaderboard),
                    label: 'Leaderboard',
                  ),
                ],
              )
              : null,
    );
  }
}
