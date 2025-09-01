import 'package:anystay/views/home_screen.dart';
import 'package:anystay/views/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController {
  Future<void> completeOnboarding(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    //Navigate to the main app screen (e.g., HomeScreen) and remove all previous routes
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=> const MainScreen())
    );

  }

  Future<void> skipOnboarding(BuildContext context) async{

    await completeOnboarding(context);
  }
}
