import 'package:anystay/controllers/onboarding_controller.dart';
import 'package:anystay/models/onboarding_model.dart';
import 'package:anystay/views/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final OnboardingController _controller = OnboardingController();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: _pageController,
          itemCount: onbordingData.length,
          onPageChanged: (int page) {
            setState(() => _currentPage = page);
          },
          itemBuilder: (_, index) {
            final page = onbordingData[index];

            return OnboardingPage(
              model: page,
              currentPage: _currentPage,
              totalPages: onbordingData.length,
              pageController: _pageController,
              onSkip: () => _controller.skipOnboarding(context),
              onComplete: () => _controller.completeOnboarding(context),
            );
          }),
    );
  }
}
