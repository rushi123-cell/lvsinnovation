import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('Party Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Chats Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile Screen', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: Container(
        height: 68,
        width: 68,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.sensors, color: AppColors.primary, size: 34),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomAppBar(
            padding: EdgeInsets.zero,
            color: Colors.transparent,
            shape: const CircularNotchedRectangle(),
            notchMargin: 12.0,
            clipBehavior: Clip.antiAlias, // This ensures the gradient container is clipped by the notch
            child: Container(
              height: 75,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.waveGradientEnd, AppColors.waveGradientStart],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_rounded, 'Home'),
                  _buildNavItem(1, Icons.celebration_outlined, 'Party'),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30), // Match the height of the icons above the other texts
                      Text('Go Live', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  _buildNavItem(2, Icons.near_me_outlined, 'Chats'),
                  _buildNavItem(3, Icons.person_outline_rounded, 'Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.white70, size: isSelected ? 28 : 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
