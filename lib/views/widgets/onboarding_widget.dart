import 'package:anystay/models/onboarding_model.dart';
import 'package:anystay/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;
  final int currentPage;
  final int totalPages;
  final PageController pageController;
  final VoidCallback onSkip;
  final VoidCallback onComplete;

  const OnboardingPage(
      {super.key,
      required this.model,
      required this.currentPage,
      required this.totalPages,
      required this.pageController,
      required this.onSkip,
      required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Screen Background
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          )),
        ),

        //The white box
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
              height: MediaQuery.of(context).size.height *
                  0.7, // Takes half screen height
              decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              padding: const EdgeInsets.all(24),
              child: Stack(children: [
                Positioned(
                    top: 90,
                    right: 0,
                    left: 0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 90),

                          Text(
                            model.title,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: AppTheme.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            model.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(height: 1.5),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 70),

                          // Bottom section (takes about 1/4 of the space)
                          Positioned(
                            top: 50,
                              right: 0,
                              left: 0,
                              child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.2, // Flexible height
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Page Indicator
                                    _buildLineIndicator(
                                        currentPage, totalPages, context),

                                    //Get started Button
                                    currentPage == totalPages - 1
                                        ? ElevatedButton(
                                            onPressed: onComplete,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppTheme.primaryColor,
                                              foregroundColor: Colors.white,
                                              minimumSize: const Size(
                                                  double.infinity, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            child: const Text('Get Started'),
                                          )
                                        : Row(
                                            children: [
                                              // Skip Button
                                              TextButton(
                                                onPressed: onSkip,
                                                child: Text(
                                                  'Skip',
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme.primaryColor,
                                                      fontSize: 16,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),

                                              const Spacer(),

                                              // Next Button
                                              FloatingActionButton(
                                                onPressed: () {
                                                  pageController.nextPage(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeIn,
                                                  );
                                                },
                                                backgroundColor:
                                                    AppTheme.primaryColor,
                                                foregroundColor: Colors.white,
                                                child: const Icon(
                                                    Icons.arrow_forward),
                                              ),
                                            ],
                                          ),
                                  ])))
                        ]))
              ])),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            right: 0,
            left: 0,
            child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(model.imagePath),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                )))
      ],
    );
  }
}

Widget _buildLineIndicator(
    int currentPage, int totalPages, BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 8),

      // Use the indicator builder from the parent state
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < totalPages; i++)
            i == currentPage
                ? _buildActiveIndicator()
                : _buildInactiveIndicator(),
        ],
      ),
    ],
  );
}

Widget _buildActiveIndicator() {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 6,
    width: 42,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: AppTheme.primaryColor, // Use your theme color
    ),
  );
}

Widget _buildInactiveIndicator() {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 8,
    width: 8,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color:
          AppTheme.textSecondaryColor.withOpacity(0.3), // Use your theme color
    ),
  );
}
