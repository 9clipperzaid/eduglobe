import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eduglobe/main.dart';
import 'package:eduglobe/screens/home_screen.dart';
import 'package:eduglobe/screens/login_screen.dart';
import 'package:eduglobe/screens/onboarding_screen.dart';
import 'package:eduglobe/screens/splash_screen.dart';
import 'package:eduglobe/services/local_storage_service.dart';
import 'package:eduglobe/widgets/app_logo.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorageService.init();
  });

  testWidgets('AppLogo widget renders with title and subtitle',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppLogo(
            size: 100,
            showText: true,
            subtitle: 'Your journey to global education',
          ),
        ),
      ),
    );

    expect(find.text('Edu'), findsOneWidget);
    expect(find.text('Globe'), findsOneWidget);
    expect(find.text('Your journey to global education'), findsOneWidget);
  });

  testWidgets('SplashScreen renders branding and transitions safely',
      (WidgetTester tester) async {
    await tester.pumpWidget(const EduGlobeApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Edu'), findsOneWidget);
    expect(find.text('Globe'), findsOneWidget);

    // Advance clock past the splash screen delay (2200ms)
    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pumpAndSettle();

    // After first launch, user lands on Onboarding
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });

  testWidgets('OnboardingScreen slides forward and completes',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );

    // Initial slide 1: Explore Universities
    expect(find.text('Explore Universities'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Advance to slide 2
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Find the Right Course'), findsOneWidget);

    // Advance to slide 3
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Plan Your Journey'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap Get Started
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify Onboarding flag is saved
    expect(LocalStorageService.isOnboardingCompleted(), isTrue);
    // Navigated to login
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('LoginScreen shows validation errors on empty fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);

    // Tap login button without filling fields
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('LoginScreen auto-fill fills demo credentials',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    expect(find.text('Auto-fill'), findsOneWidget);
    await tester.tap(find.text('Auto-fill'));
    await tester.pumpAndSettle();

    expect(find.text('alex.student@eduglobe.com'), findsOneWidget);
  });

  testWidgets('HomeScreen renders welcome header, destinations, and university cards',
      (WidgetTester tester) async {
    await LocalStorageService.saveUserLogin(
      email: 'alex@eduglobe.com',
      name: 'Alex',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Hello, Alex 👋'), findsOneWidget);
    expect(find.text('Popular Destinations'), findsOneWidget);
    expect(find.text('Featured Universities'), findsOneWidget);
    expect(find.text('University of Oxford'), findsOneWidget);
  });
}
