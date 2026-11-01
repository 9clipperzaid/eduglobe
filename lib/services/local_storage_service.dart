import 'package:shared_preferences/shared_preferences.dart';

/// Service responsible for managing local persistence for EduGlobe.
/// Handles onboarding completion, login state, and user credentials.
class LocalStorageService {
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserName = 'user_name';

  static SharedPreferences? _prefs;

  /// Initializes the SharedPreferences instance.
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Checks if the user has previously completed the onboarding flow.
  static bool isOnboardingCompleted() {
    return _prefs?.getBool(_keyOnboardingCompleted) ?? false;
  }

  /// Marks the onboarding flow as completed.
  static Future<bool> setOnboardingCompleted(bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setBool(_keyOnboardingCompleted, value);
  }

  /// Checks if the user is currently logged in.
  static bool isLoggedIn() {
    return _prefs?.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Sets the user's login state and stores their email and display name.
  static Future<void> saveUserLogin({
    required String email,
    String? name,
  }) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(_keyIsLoggedIn, true);
    await _prefs!.setString(_keyUserEmail, email);
    final displayName = name ?? email.split('@').first;
    // Capitalize first letter of display name
    final capitalized = displayName.isNotEmpty
        ? displayName[0].toUpperCase() + displayName.substring(1)
        : 'Student';
    await _prefs!.setString(_keyUserName, capitalized);
  }

  /// Retrieves the stored user email or returns a default.
  static String getUserEmail() {
    return _prefs?.getString(_keyUserEmail) ?? 'student@eduglobe.com';
  }

  /// Retrieves the stored user display name.
  static String getUserName() {
    return _prefs?.getString(_keyUserName) ?? 'Alex';
  }

  /// Clears the login state and user information upon logout.
  /// Preserves onboarding completion so the user doesn't see onboarding again.
  static Future<void> logout() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(_keyIsLoggedIn, false);
    await _prefs!.remove(_keyUserEmail);
    await _prefs!.remove(_keyUserName);
  }

  /// Completely clears all data (used for debugging/development testing).
  static Future<void> resetAll() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.clear();
  }
}
