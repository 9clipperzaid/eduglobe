import 'package:flutter/material.dart';
import '../app/app_theme.dart';
import '../models/onboarding_item.dart';
import '../services/local_storage_service.dart';
import '../widgets/primary_button.dart';

/// Screen 2: Onboarding Screen
/// Features 3 interactive swipeable slides explaining the app value,
/// page indicators, smooth page transitions, and local persistence.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<OnboardingItem> _slides = OnboardingItem.items;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboardingAndGoToLogin() async {
    // Save onboarding completion to prevent showing again on subsequent launches
    await LocalStorageService.setOnboardingCompleted(true);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void _onNextPressed() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboardingAndGoToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == _slides.length - 1;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // Skip button
          TextButton(
            onPressed: _completeOnboardingAndGoToLogin,
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.textSecondary,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Swipeable Slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return _buildSlideContent(slide);
                },
              ),
            ),

            // Bottom Section: Page Indicators + Action Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page Indicators (Animated Dots/Pills)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => _buildIndicator(index == _currentIndex),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons (Next / Get Started)
                  PrimaryButton(
                    label: isLastPage ? 'Get Started' : 'Next',
                    icon: isLastPage
                        ? Icons.check_circle_outline_rounded
                        : Icons.arrow_forward_rounded,
                    onPressed: _onNextPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlideContent(OnboardingItem slide) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 560;
        final illustrationSize = compact ? 180.0 : 240.0;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          SizedBox(height: compact ? 8 : 20),

          // Illustration / Icon Graphic Composition
          _buildIllustration(slide, size: illustrationSize),

          SizedBox(height: compact ? 12 : 28),

          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: slide.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              slide.tag,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: slide.accentColor,
                letterSpacing: 1.1,
              ),
            ),
          ),

          SizedBox(height: compact ? 10 : 18),

          // Slide Title
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: compact ? 23 : 26,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              letterSpacing: -0.5,
              height: 1.25,
            ),
          ),

          SizedBox(height: compact ? 8 : 14),

          // Slide Description
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: compact ? 14 : 15,
              fontWeight: FontWeight.w400,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),

          const Spacer(flex: 1),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIllustration(OnboardingItem slide, {required double size}) {
    final scale = size / 240;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer subtle circular ring
          Container(
            width: size * 0.96,
            height: size * 0.96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: slide.accentColor.withValues(alpha: 0.05),
              border: Border.all(
                color: slide.accentColor.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
          ),

          // Inner gradient circle
          Container(
            width: size * 0.71,
            height: size * 0.71,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  slide.accentColor.withValues(alpha: 0.20),
                  slide.accentColor.withValues(alpha: 0.08),
                ],
              ),
            ),
          ),

          // Central Hero Icon
          Container(
            width: size * 0.46,
            height: size * 0.46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  slide.accentColor,
                  AppTheme.primaryDark,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: slide.accentColor.withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              slide.icon,
              size: 54 * scale,
              color: Colors.white,
            ),
          ),

          // Floating small decorative bubble 1
          Positioned(
            top: size * 0.10,
            right: size * 0.15,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.star_rounded,
                color: const Color(0xFFFBBF24),
                size: 20,
              ),
            ),
          ),

          // Floating small decorative bubble 2
          Positioned(
            bottom: size * 0.13,
            left: size * 0.13,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.public_rounded,
                color: slide.accentColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 26 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primary : AppTheme.cardBorder,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
