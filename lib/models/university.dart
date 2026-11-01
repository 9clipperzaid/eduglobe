import 'package:flutter/material.dart';

/// Model representing a university profile displayed on the Home screen.
class University {
  final String id;
  final String name;
  final String country;
  final String city;
  final String ranking;
  final String acceptanceRate;
  final String annualTuition;
  final String flagEmoji;
  final IconData badgeIcon;
  final Color badgeColor;

  const University({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.ranking,
    required this.acceptanceRate,
    required this.annualTuition,
    required this.flagEmoji,
    required this.badgeIcon,
    required this.badgeColor,
  });

  static const List<University> sampleUniversities = [
    University(
      id: 'oxford',
      name: 'University of Oxford',
      country: 'United Kingdom',
      city: 'Oxford',
      ranking: '#1 Global Rank',
      acceptanceRate: '17% Acceptance',
      annualTuition: '£28,000 / yr',
      flagEmoji: '🇬🇧',
      badgeIcon: Icons.castle_rounded,
      badgeColor: Color(0xFF1D4ED8),
    ),
    University(
      id: 'mit',
      name: 'Massachusetts Institute of Technology',
      country: 'United States',
      city: 'Cambridge, MA',
      ranking: '#2 Global Rank',
      acceptanceRate: '4.1% Acceptance',
      annualTuition: '\$59,000 / yr',
      flagEmoji: '🇺🇸',
      badgeIcon: Icons.biotech_rounded,
      badgeColor: Color(0xFF0F2B66),
    ),
    University(
      id: 'toronto',
      name: 'University of Toronto',
      country: 'Canada',
      city: 'Toronto, ON',
      ranking: '#21 Global Rank',
      acceptanceRate: '43% Acceptance',
      annualTuition: 'CAD \$42,000 / yr',
      flagEmoji: '🇨🇦',
      badgeIcon: Icons.nature_people_rounded,
      badgeColor: Color(0xFF0EA5E9),
    ),
    University(
      id: 'melbourne',
      name: 'University of Melbourne',
      country: 'Australia',
      city: 'Melbourne, VIC',
      ranking: '#33 Global Rank',
      acceptanceRate: '70% Acceptance',
      annualTuition: 'AUD \$38,000 / yr',
      flagEmoji: '🇦🇺',
      badgeIcon: Icons.wb_sunny_rounded,
      badgeColor: Color(0xFF2563EB),
    ),
  ];
}

/// Model representing popular destinations for studying abroad.
class StudyDestination {
  final String name;
  final String countryCode;
  final String universitiesCount;
  final String flagEmoji;
  final IconData icon;

  const StudyDestination({
    required this.name,
    required this.countryCode,
    required this.universitiesCount,
    required this.flagEmoji,
    required this.icon,
  });

  static const List<StudyDestination> sampleDestinations = [
    StudyDestination(
      name: 'United Kingdom',
      countryCode: 'UK',
      universitiesCount: '150+ Unis',
      flagEmoji: '🇬🇧',
      icon: Icons.location_city_rounded,
    ),
    StudyDestination(
      name: 'United States',
      countryCode: 'USA',
      universitiesCount: '350+ Unis',
      flagEmoji: '🇺🇸',
      icon: Icons.apartment_rounded,
    ),
    StudyDestination(
      name: 'Canada',
      countryCode: 'CAN',
      universitiesCount: '95+ Unis',
      flagEmoji: '🇨🇦',
      icon: Icons.holiday_village_rounded,
    ),
    StudyDestination(
      name: 'Australia',
      countryCode: 'AUS',
      universitiesCount: '40+ Unis',
      flagEmoji: '🇦🇺',
      icon: Icons.beach_access_rounded,
    ),
    StudyDestination(
      name: 'Germany',
      countryCode: 'GER',
      universitiesCount: '80+ Unis',
      flagEmoji: '🇩🇪',
      icon: Icons.account_balance_rounded,
    ),
  ];
}
