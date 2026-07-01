import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../main/main_screen.dart';
import '../widgets/curve_clipper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size.height),
          child: IntrinsicHeight(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                // App Logo
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Alive', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                        Icon(Icons.videocam, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Welcome Text
                const Text(
                  'Welcome back! 👋',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue your live streaming journey.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sign in with your Google account to get started.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                // Bottom Wave
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.45,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.waveGradientStart, AppColors.waveGradientEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.5))),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text('Continue With', style: TextStyle(color: Colors.white, fontSize: 14)),
                              ),
                              Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.5))),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Google Auth Button
                          Consumer<AuthViewModel>(
                            builder: (context, authVM, child) {
                              return ElevatedButton(
                                onPressed: authVM.isLoading
                                    ? null
                                    : () async {
                                        final success = await authVM.signInWithGoogle();
                                        if (success && context.mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => const MainScreen()),
                                          );
                                        } else if (authVM.errorMessage != null && context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(authVM.errorMessage!)),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (authVM.isLoading)
                                      const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    else ...[
                                      Image.network(
                                        'https://developers.google.com/identity/images/g-logo.png',
                                        height: 24,
                                      ),
                                      const SizedBox(width: 12),
                                      const Text('Continue with Google', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    ]
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? ", style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () {},
                                child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: Colors.white)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
