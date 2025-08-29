import 'package:anystay/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingController {
  Future<void> completeOnboarding(BuildContext context) async {

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=> const HomeScreen())
    );

  }

  Future<void> skipOnboarding(BuildContext context) async{

    await completeOnboarding(context);
  }
}
