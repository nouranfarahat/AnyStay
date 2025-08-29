class OnboardingModel{

  String title;
  String description;
  String imagePath;

  OnboardingModel(
      this.title,
      this.description,
      this.imagePath);
}

List<OnboardingModel> onbordingData=[
  OnboardingModel(
      "Discover New Adventures",
      "Find the best attractions, hidden gems, and can't-miss experiences for your trip",
      "assets/images/map.png"),
  OnboardingModel(
      "Navigate with Ease",
      "Get directions to every destination and make the most of your vacation",
      "assets/images/discover.png"),
  OnboardingModel(
      "Plan Your Perfect Day",
      "Build your itinerary with opening hours, prices, and ratings all in one place",
      "assets/images/begin.png"),
];