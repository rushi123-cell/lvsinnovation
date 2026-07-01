import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _pulseController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseScaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    // Entrance Animations
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _rotationAnimation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutBack),
    );

    // Pulse/Glow Animations (continuous after entrance)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _pulseScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 15.0, end: 40.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start entrance, then trigger pulse
    _entranceController.forward().then((_) {
      if (mounted) _pulseController.repeat(reverse: true);
    });

    // Navigate to Login after 4 seconds total
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_entranceController, _pulseController]),
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                // Combine entrance scale with the subtle pulse scale
                scale: _scaleAnimation.value * _pulseScaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.gradientStart, AppColors.gradientEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          blurRadius: _glowAnimation.value, // Dynamic glow
                          spreadRadius: _glowAnimation.value / 4,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Alive',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1.5,
                            ),
                          ),
                          SizedBox(height: 6),
                          Icon(Icons.videocam, color: Colors.white, size: 42),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
