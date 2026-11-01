import 'package:flutter/material.dart';
import '../app/app_theme.dart';
import '../services/local_storage_service.dart';
import '../widgets/app_logo.dart';

/// Screen 1: Splash Screen
/// Introduces the app with custom graphical design, deep blue gradient,
/// animated logo, and routes the user based on persistent local state.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  bool _didNavigate = false;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.2, 0.9, curve: Curves.easeIn),
    );

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeInOut,
      ),
    );

    _animController.forward();
    _continueToOnboarding();
  }

  Future<void> _continueToOnboarding() async {
    await Future.wait([
      LocalStorageService.init(),
      Future<void>.delayed(const Duration(milliseconds: 1800)),
    ]);
    if (!mounted || _didNavigate) return;
    _didNavigate = true;
    final nextRoute = LocalStorageService.isLoggedIn()
        ? '/home'
        : LocalStorageService.isOnboardingCompleted()
            ? '/login'
            : '/onboarding';
    Navigator.of(context).pushReplacementNamed(nextRoute);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppTheme.splashGradient,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Abstract graphical background elements
            _buildBackgroundGraphics(size),

            // Central Branding Content
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),

                    // Animated Logo
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) => Transform.scale(
                            scale: _pulseAnimation.value,
                            child: child,
                          ),
                          child: const AppLogo(
                            size: 130,
                            showText: true,
                            isDarkBackground: true,
                            subtitle: 'Your journey to global education',
                          ),
                        ),
                      ),
                    ),

                    const Spacer(flex: 3),

                    // Loading indicator & subtle footer
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color(0xFF38BDF8).withValues(alpha: 0.8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Connecting to Top Universities worldwide...',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.65),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundGraphics(Size size) {
    return Stack(
      children: [
        // Top right luminous orb
        Positioned(
          top: -size.width * 0.3,
          right: -size.width * 0.3,
          child: Container(
            width: size.width * 0.85,
            height: size.width * 0.85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF38BDF8).withValues(alpha: 0.22),
                  const Color(0xFF1D4ED8).withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Bottom left subtle glow orb
        Positioned(
          bottom: -size.width * 0.25,
          left: -size.width * 0.25,
          child: Container(
            width: size.width * 0.75,
            height: size.width * 0.75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF2563EB).withValues(alpha: 0.20),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Custom subtle background geometric curved lines
        Positioned.fill(
          child: CustomPaint(
            painter: _SplashWavePainter(),
          ),
        ),
      ],
    );
  }
}

/// Subtle vector background curves for enhanced splash graphic design
class _SplashWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.25);
    path1.cubicTo(
      size.width * 0.3,
      size.height * 0.18,
      size.width * 0.7,
      size.height * 0.32,
      size.width,
      size.height * 0.22,
    );
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);
    path2.cubicTo(
      size.width * 0.35,
      size.height * 0.85,
      size.width * 0.65,
      size.height * 0.68,
      size.width,
      size.height * 0.78,
    );
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
