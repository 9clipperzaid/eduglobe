import 'package:flutter/material.dart';
import '../app/app_theme.dart';
import '../models/university.dart';

/// Card widget to display university details with ranking, location,
/// acceptance rate, and tuition information.
class UniversityCard extends StatelessWidget {
  final University university;
  final VoidCallback? onTap;

  const UniversityCard({
    super.key,
    required this.university,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.cardBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap ??
              () {
                _showDetailsModal(context, university);
              },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Badge Icon + Name & City + Bookmark
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // University Emblem / Placeholder Icon Container
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            university.badgeColor.withValues(alpha: 0.15),
                            university.badgeColor.withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: university.badgeColor.withValues(alpha: 0.3),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          university.badgeIcon,
                          color: university.badgeColor,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Name & Location
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            university.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                university.flagEmoji,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  '${university.city}, ${university.country}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.textSecondary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Favorite icon
                    IconButton(
                      icon: const Icon(
                        Icons.bookmark_border_rounded,
                        color: AppTheme.textMuted,
                        size: 22,
                      ),
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Saved ${university.name} to shortlist!'),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppTheme.primaryDark,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Divider
                Container(
                  height: 1,
                  color: AppTheme.cardBorder.withValues(alpha: 0.7),
                ),
                const SizedBox(height: 12),
                // Badges Row: Ranking, Acceptance Rate, Tuition
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetaTag(
                      icon: Icons.emoji_events_rounded,
                      text: university.ranking,
                      color: const Color(0xFFD97706),
                      bgColor: const Color(0xFFFEF3C7),
                    ),
                    _buildMetaTag(
                      icon: Icons.check_circle_outline_rounded,
                      text: university.acceptanceRate,
                      color: const Color(0xFF059669),
                      bgColor: const Color(0xFFD1FAE5),
                    ),
                    _buildMetaTag(
                      icon: Icons.payments_outlined,
                      text: university.annualTuition,
                      color: AppTheme.primary,
                      bgColor: const Color(0xFFEFF6FF),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetaTag({
    required IconData icon,
    required String text,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailsModal(BuildContext context, University university) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: university.badgeColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    university.badgeIcon,
                    color: university.badgeColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        university.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${university.flagEmoji} ${university.city}, ${university.country}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.scaffoldBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _modalInfoRow('Global Ranking', university.ranking),
                  const Divider(height: 18),
                  _modalInfoRow('Acceptance Rate', university.acceptanceRate),
                  const Divider(height: 18),
                  _modalInfoRow('Estimated Tuition', university.annualTuition),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Application guide for ${university.name} initiated!'),
                    backgroundColor: AppTheme.primary,
                  ),
                );
              },
              child: const Text('Start Free Application Guide'),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _modalInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
