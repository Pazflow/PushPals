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
                    onPressed: () => context.go('/challenge_hinzufuegen'),
                    icon: Icons.add,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ))
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
          showBottomNav
              ? Container(
                height: 55, // 🔥 Hier frei wählbar, z. B. 44, 48, 52
                color: const Color(0xFF0084FF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context,
                      icon: Icons.home,
                      label: 'Home',
                      index: 0,
                      isSelected: selectedIndex == 0,
                      route: '/home',
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.leaderboard,
                      label: 'Best of',
                      index: 1,
                      isSelected: selectedIndex == 1,
                      route: '/leaderboard',
                    ),
                    const SizedBox(width: 48), // Abstand für FloatingButton
                    _buildNavItem(
                      context,
                      icon: Icons.diversity_3,
                      label: 'Friends',
                      index: 2,
                      isSelected: selectedIndex == 2,
                      route: '/meine_freunde',
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.other_houses,
                      label: 'Duell',
                      index: 3,
                      isSelected: selectedIndex == 3,
                      route: '/gesendete_challenges',
                    ),
                  ],
                ),
              )
              : null,
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:
                  isSelected
                      ? const Color(0xFFCBB90F)
                      : const Color(0xFFFFFFFF),
              size: 26,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
