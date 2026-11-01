import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../app/app_theme.dart';

/// Custom graphical logo for EduGlobe.
/// Renders a beautifully styled globe with graduation cap, orbital ring,
/// and geometric vector details using CustomPainter for crisp rendering on all screens.
class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool isDarkBackground;
  final String? subtitle;

  const AppLogo({
    super.key,
    this.size = 100,
    this.showText = false,
    this.isDarkBackground = false,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = isDarkBackground ? Colors.white : AppTheme.textPrimary;
    final subColor = isDarkBackground
        ? const Color(0xFFBAE6FD)
        : AppTheme.textSecondary;

    Widget logoGraphic = SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft glow
          Container(
            width: size * 0.85,
            height: size * 0.85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isDarkBackground
                      ? const Color(0xFF38BDF8).withValues(alpha: 0.35)
                      : AppTheme.primary.withValues(alpha: 0.25),
                  blurRadius: size * 0.35,
                  spreadRadius: size * 0.05,
                ),
              ],
            ),
          ),
          // Vector custom painted globe + orbit + graduation elements
          CustomPaint(
            size: Size(size, size),
            painter: _EduGlobePainter(isDarkBackground: isDarkBackground),
          ),
        ],
      ),
    );

    if (!showText) {
      return logoGraphic;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        logoGraphic,
        SizedBox(height: size * 0.15),
        // App Title
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edu',
              style: TextStyle(
                fontSize: size * 0.28,
                fontWeight: FontWeight.w800,
                color: titleColor,
                letterSpacing: -0.5,
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF38BDF8), Color(0xFF60A5FA)],
              ).createShader(bounds),
              child: Text(
                'Globe',
                style: TextStyle(
                  fontSize: size * 0.28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: math.max(12.0, size * 0.12),
              fontWeight: FontWeight.w500,
              color: subColor,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ],
    );
  }
}

class _EduGlobePainter extends CustomPainter {
  final bool isDarkBackground;

  _EduGlobePainter({required this.isDarkBackground});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + size.height * 0.04);
    final globeRadius = size.width * 0.32;

    // 1. Globe Base Circle with Linear Gradient
    final globeRect = Rect.fromCircle(center: center, radius: globeRadius);
    final globeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDarkBackground
          ? const [
              Color(0xFF38BDF8),
              Color(0xFF2563EB),
              Color(0xFF1D4ED8),
              Color(0xFF0F2B66),
            ]
          : const [
              Color(0xFF60A5FA),
              Color(0xFF2563EB),
              Color(0xFF1D4ED8),
            ],
    );

    final globePaint = Paint()
      ..shader = globeGradient.createShader(globeRect)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, globeRadius, globePaint);

    // 2. Latitude & Longitude Grid Lines (Stylized Globe)
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.2, size.width * 0.015);

    // Equator line
    canvas.drawLine(
      Offset(center.dx - globeRadius, center.dy),
      Offset(center.dx + globeRadius, center.dy),
      gridPaint,
    );

    // Curved Latitudes
    final lat1Rect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - globeRadius * 0.4),
      width: globeRadius * 1.8,
      height: globeRadius * 0.7,
    );
    canvas.drawArc(lat1Rect, 0.2, math.pi - 0.4, false, gridPaint);

    final lat2Rect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + globeRadius * 0.4),
      width: globeRadius * 1.8,
      height: globeRadius * 0.7,
    );
    canvas.drawArc(lat2Rect, math.pi + 0.2, math.pi - 0.4, false, gridPaint);

    // Meridian (Vertical Ellipse)
    final meridianRect = Rect.fromCenter(
      center: center,
      width: globeRadius * 0.9,
      height: globeRadius * 2,
    );
    canvas.drawOval(meridianRect, gridPaint);

    // 3. Dynamic Elliptical Orbit Ring
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-math.pi / 6); // 30-degree orbit slant

    final orbitRect = Rect.fromCenter(
      center: Offset.zero,
      width: globeRadius * 2.5,
      height: globeRadius * 0.85,
    );

    final orbitPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF38BDF8),
          Colors.white,
          Color(0xFF60A5FA),
          Colors.transparent,
        ],
        stops: [0.0, 0.4, 0.7, 1.0],
      ).createShader(orbitRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.8, size.width * 0.022);

    canvas.drawOval(orbitRect, orbitPaint);

    // Star / Satellite dot on the orbit
    final satelliteCenter = Offset(globeRadius * 1.25, 0);
    final satellitePaint = Paint()
      ..color = const Color(0xFFFDE047) // Golden yellow spark
      ..style = PaintingStyle.fill;
    canvas.drawCircle(satelliteCenter, math.max(2.5, size.width * 0.035), satellitePaint);

    // Glow around satellite
    final satGlowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(satelliteCenter, math.max(4.0, size.width * 0.05), satGlowPaint);

    canvas.restore();

    // 4. Stylized Graduation Cap (Mortarboard) on top
    final capWidth = size.width * 0.48;
    final capHeight = size.height * 0.18;
    final capCenter = Offset(center.dx, center.dy - globeRadius * 0.85);

    // Mortarboard Diamond
    final capPath = Path();
    capPath.moveTo(capCenter.dx, capCenter.dy - capHeight * 0.5); // Top vertex
    capPath.lineTo(capCenter.dx + capWidth * 0.5, capCenter.dy); // Right vertex
    capPath.lineTo(capCenter.dx, capCenter.dy + capHeight * 0.5); // Bottom vertex
    capPath.lineTo(capCenter.dx - capWidth * 0.5, capCenter.dy); // Left vertex
    capPath.close();

    final capPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1E293B),
          Color(0xFF0F172A),
        ],
      ).createShader(Rect.fromCenter(center: capCenter, width: capWidth, height: capHeight))
      ..style = PaintingStyle.fill;

    // Subtle drop shadow under cap
    canvas.drawPath(
      capPath.shift(Offset(0, size.height * 0.015)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    canvas.drawPath(capPath, capPaint);

    // Cap border highlight
    final capBorderPaint = Paint()
      ..color = const Color(0xFF38BDF8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.2, size.width * 0.014);
    canvas.drawPath(capPath, capBorderPaint);

    // Skull cap base underneath
    final skullCapRect = Rect.fromCenter(
      center: Offset(capCenter.dx, capCenter.dy + capHeight * 0.35),
      width: capWidth * 0.5,
      height: capHeight * 0.4,
    );
    final skullCapPaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;
    canvas.drawArc(skullCapRect, 0, math.pi, true, skullCapPaint);

    // Golden Button and Tassel
    final buttonPaint = Paint()
      ..color = const Color(0xFFFBBF24) // Gold
      ..style = PaintingStyle.fill;
    canvas.drawCircle(capCenter, math.max(2.5, size.width * 0.025), buttonPaint);

    // Tassel ribbon hanging down to the right
    final tasselPath = Path();
    tasselPath.moveTo(capCenter.dx, capCenter.dy);
    tasselPath.quadraticBezierTo(
      capCenter.dx + capWidth * 0.35,
      capCenter.dy + capHeight * 0.2,
      capCenter.dx + capWidth * 0.42,
      capCenter.dy + capHeight * 0.9,
    );

    final tasselPaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.5, size.width * 0.016)
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(tasselPath, tasselPaint);

    // Tassel fringe end
    canvas.drawCircle(
      Offset(capCenter.dx + capWidth * 0.42, capCenter.dy + capHeight * 0.95),
      math.max(2.0, size.width * 0.02),
      buttonPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _EduGlobePainter oldDelegate) {
    return oldDelegate.isDarkBackground != isDarkBackground;
  }
}
