import 'package:flutter/material.dart';
import 'package:petfinder/injection/injection_container.dart';

final class AppStartup {
  const AppStartup._();

  ///
  /// Run the startup process
  /// This method should be called in the main method
  ///
  ///
  static Future<void> init() async {
    try {
      await _configureDependencies();
    } catch (e) {
      debugPrint('Error on startup: $e');
    }
  }

  ///
  /// Configure Dependencies for the GetIt Service Locator
  ///
  static Future<void> _configureDependencies() async {
    await configureDependencies(defaultEnv: 'real');
  }
}
