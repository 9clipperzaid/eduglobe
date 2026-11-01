import 'package:flutter/material.dart';

/// Model representing a single slide in the onboarding flow.
class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;
  final String tag;
  final Color accentColor;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.tag,
    required this.accentColor,
  });

  static const List<OnboardingItem> items = [
    OnboardingItem(
      title: 'Explore Universities',
      description:
          'Discover world-class universities, accredited programs, and international rankings tailored to your ambitions.',
      icon: Icons.account_balance_rounded,
      tag: 'GLOBAL REACH',
      accentColor: Color(0xFF2563EB),
    ),
    OnboardingItem(
      title: 'Find the Right Course',
      description:
          'Compare curriculum, admission eligibility, tuition fees, and scholarship opportunities in one simple place.',
      icon: Icons.school_rounded,
      tag: 'SMART SEARCH',
      accentColor: Color(0xFF0EA5E9),
    ),
    OnboardingItem(
      title: 'Plan Your Journey',
      description:
          'Receive step-by-step guidance from university applications and visa processing to your campus arrival.',
      icon: Icons.flight_takeoff_rounded,
      tag: 'STUDY ABROAD',
      accentColor: Color(0xFF3B82F6),
    ),
  ];
}
